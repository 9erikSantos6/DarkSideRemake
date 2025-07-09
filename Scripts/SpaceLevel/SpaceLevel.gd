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

var player_pontuation = 0

var hud_in_game: Variant

func _ready():
	Game.reset_player_stage_score()
	instance_nodes()
	$start_spawn_enemies.start()

	hud_in_game.update_player_integrity(Enums.PlayerType.Player1, 100)
	hud_in_game.update_player_integrity(Enums.PlayerType.Player2, 100)


func _process(_delta: float) -> void:
	update_hud()


func instance_nodes():
	Game.instance_node(space_parallax_bg, self)
	Game.instance_node(player_scene, self)
	Game.instance_node(player_2_scene, self)

	hud_in_game = Game.instance_node(hud_scene, self)


func randomly_spawn_enemys():
	if randf() < spawn_enemies_probability:
		var random_amount = floor(clamp(randf() * max_enemies_horde_size + 1, 1, max_enemies_horde_size))
		for enemy in random_amount:
			Game.instance_node(enemy_scene, self)

func update_hud():
	hud_in_game.update_score(Game.get_player_stage_score())


func _exit_tree():
	queue_free()


func _on_start_spawn_enemies_timeout():
	$enemies_spawn_timer.start()


func _on_enemies_spawn_timer_timeout():
	randomly_spawn_enemys()
