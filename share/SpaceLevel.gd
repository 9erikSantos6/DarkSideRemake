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

#var new_enemy: PackedScene = preload("res://Scenes/SpaceLevel/Elements/NewEnemyBody.tscn")

var player_pontuation = 0

var hud_in_game: Variant

func _ready():
	Game.set_game_state(Enums.GameState.Playing)
	Game.set_current_level(Enums.GameLevels.SpaceLevel)
	Game.reset_player_stage_score()
	instance_nodes()
	$start_spawn_enemies.start()

	# hud_in_game.update_player_integrity(Enums.PlayerType.Player1, 100)
	# hud_in_game.update_player_integrity(Enums.PlayerType.Player2, 100)


func hello():
	print("Hello from SpaceLevel.gd")


func _process(_delta: float) -> void:
	update_hud()
	detect_player_game_over()


func instance_nodes():
	Game.instance_node(space_parallax_bg, self)
	Game.instance_node(player_scene, self)
	#Game.instance_node(player_2_scene, self)ds

	hud_in_game = Game.instance_node(hud_scene, self)


func randomly_spawn_enemys():
	if randf() < spawn_enemies_probability:
		var random_amount = floor(clamp(randf() * max_enemies_horde_size + 1, 1, max_enemies_horde_size))
		for enemy in random_amount:
			Game.instance_node(enemy_scene, self)
		#Game.instance_node(new_enemy, self)

func update_hud():
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

	if all_players_dead:
		Game.set_game_state(Enums.GameState.GameOver)
		$start_spawn_enemies.stop()
		get_tree().change_scene_to_packed(gameover_scene) 

func _exit_tree():
	Game.set_game_state(Enums.GameState.None)
	queue_free()


func _on_start_spawn_enemies_timeout():
	$enemies_spawn_timer.start()


func _on_enemies_spawn_timer_timeout():
	randomly_spawn_enemys()
