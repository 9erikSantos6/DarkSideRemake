extends Node2D

@export var enemies_spawn_interval: float = 1.0
@export var spawn_enemies_probability: float = 0.5
@export var max_enemies_horde_size: int = 2

var space_parallax_bg: PackedScene = preload("res://Scenes/SpaceLevel/Elements/SpaceParallaxBg.tscn")
var player_scene: PackedScene = preload("res://Scenes/SpaceLevel/Elements/Player.tscn")
var player_2_scene: PackedScene = preload("res://Scenes/SpaceLevel/Elements/Player.tscn")
var plasma_scene: PackedScene = preload("res://Scenes/SpaceLevel/Elements/Plasma.tscn")
var enemy_scene: PackedScene = preload("res://Scenes/SpaceLevel/Elements/Enemy.tscn")
var hud_scene: PackedScene = preload("res://UI/HUD.tscn")
var gameover_scene: PackedScene = preload("res://UI/Gameover.tscn")
var pause_menu_scene: PackedScene = preload("res://UI/PauseMenu.tscn")

#var new_enemy: PackedScene = preload("res://Scenes/SpaceLevel/Elements/NewEnemyBody.tscn")

var player_pontuation = 0

var hud_in_game: Variant

func _ready():
	Game.set_game_state(Enums.GameState.Playing)
	Game.set_current_level_type(Enums.GameLevels.SpaceLevel)
	Game.reset_player_stage_score()
	instance_nodes()
	$start_spawn_enemies.start()

	# hud_in_game.update_player_integrity(Enums.PlayerType.Player1, 100)
	# hud_in_game.update_player_integrity(Enums.PlayerType.Player2, 100)


func _process(_delta: float) -> void:
	update_hud()
	detect_player_game_over()
	detect_player_pause()


func instance_nodes():
	Game.instance_node(space_parallax_bg, self)
	instance_players()

	hud_in_game = Game.instance_node(hud_scene, self)

func instance_players():
	if Game.get_game_mode() == Enums.GameMode.MultiPlayer:
		Game.instance_node(player_2_scene, self)
		set_difficulty(Enums.GameDifficulty.DarkSide)

	set_difficulty(Enums.GameDifficulty.DarkSide)

	set_difficulty(Enums.GameDifficulty.Normal)
	Game.instance_node(player_scene, self)


func set_difficulty(difficulty: Enums.GameDifficulty):
	match difficulty:
		0:  # Fácil
			enemies_spawn_interval = 1.0
			spawn_enemies_probability = 0.5
			max_enemies_horde_size = 2

		1:  # Médio
			enemies_spawn_interval = 0.7
			spawn_enemies_probability = 0.7
			max_enemies_horde_size = 4

		2:  # Difícil
			enemies_spawn_interval = 0.4
			spawn_enemies_probability = 0.9
			max_enemies_horde_size = 6

		_:  # Caso padrão (se vier um valor inesperado)
			enemies_spawn_interval = 1.0
			spawn_enemies_probability = 0.5
			max_enemies_horde_size = 2


func randomly_spawn_enemys():
	if randf() < spawn_enemies_probability:
		var random_amount = floor(clamp(randf() * max_enemies_horde_size + 1, 1, max_enemies_horde_size))
		for enemy in random_amount:
			Game.instance_node(enemy_scene, self)
		#Game.instance_node(new_enemy, self)

func update_hud():
	if Game.get_player_nodes().size() > 0:
		hud_in_game.update_score(Game.get_player_stage_score())

		for player in Game.get_player_nodes():
			if player and player.is_in_group("player"):
				hud_in_game.update_player_integrity(player.player_index, player.integrity)


func detect_player_game_over():
	var all_players_dead = true
	for player in Game.get_player_nodes():
		if player and player.is_in_group("player"):
			if player.alive:
				all_players_dead = false
				break
	if all_players_dead and Game.get_game_state() != Enums.GameState.GameOver:
		Game.set_game_state(Enums.GameState.GameOver)
		clear_children()
		call_deferred("change_to_gameover")


func change_to_gameover():
	var gameover_screen = gameover_scene.instantiate()
	get_tree().root.add_child(gameover_screen)
	queue_free()


func detect_player_pause():
	for player in Game.get_player_nodes():
		if Input.is_action_pressed("player_%s_start" % str(player.player_index)) and Game.get_game_state() == Enums.GameState.Playing:
			Game.set_game_state(Enums.GameState.Paused)
			get_tree().paused = true
			var pause_menu_screen = pause_menu_scene.instantiate()
			add_child(pause_menu_screen)



func clear_children():
	for child in get_children():
		child.queue_free()


func _exit_tree():
	Game.set_game_state(Enums.GameState.None)
	queue_free()


func _on_start_spawn_enemies_timeout():
	$enemies_spawn_timer.start()


func _on_enemies_spawn_timer_timeout():
	randomly_spawn_enemys()
