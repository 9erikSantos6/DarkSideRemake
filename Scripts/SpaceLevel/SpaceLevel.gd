extends Node2D

@export var enemies_spawn_interval: float = 1.0
@export var spawn_enemies_probability: float = 0.5
@export var max_enemies_horde_size: int = 2

@export var player_scene = preload("res://Scenes/SpaceLevel/Elements/Player.tscn")
@export var plasma_scene = preload("res://Scenes/SpaceLevel/Elements/Plasma.tscn")
@export var enemy_scene = preload("res://Scenes/SpaceLevel/Elements/Enemy.tscn")

var player_pontuation = 0

func _ready():
	init_game()
	
func _process(_delta):
	pass

func init_game():
	randomize()
	Global.node_game = self
	instance_nodes()
	$start_spawn_enemies.start()

func instance_nodes():
	Global.instance_node(player_scene, self)

func _on_start_spawn_enemies_timeout():
	$enemies_spawn_timer.start()

func _on_enemies_spawn_timer_timeout():
	randomly_spawn_enemys()

func randomly_spawn_enemys():
	if randf() < spawn_enemies_probability:
		var random_amount = floor(clamp(randf() * max_enemies_horde_size + 1, 1, max_enemies_horde_size))
		for enemy in random_amount:
			Global.instance_node(enemy_scene, self)

func _exit_tree():
	Global.node_game = null
	queue_free()
