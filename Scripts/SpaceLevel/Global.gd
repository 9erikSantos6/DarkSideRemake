extends Node

var soundFx_scene = preload("res://Scenes/SpaceLevel/SondFx/SoundFx.tscn")

var score := 0

var space_node_main: Node2D

var player_nodes: Array[Area2D] = []

var screen_size: Vector2 = Vector2.ZERO

enum GalaxysType {
	GalaxyA,
	GalaxyB,
	GalaxyC
}

func add_player(layer: Area2D) -> int:
	player_nodes.append(layer)
	return player_nodes.size() - 1

func _ready():
	screen_size = get_viewport().size


func _process(_delta):
	screen_size = get_viewport().size


func instance_node(scene_name, parent):
	var new_node = scene_name.instantiate()
	parent.add_child(new_node)
	return new_node


func instance_node_in_position(scene_name, position, parent):
	var new_node = scene_name.instantiate()
	parent.add_child(new_node)
	new_node.global_position = position
	return new_node


func instace_sound_fx():
	var new_node = soundFx_scene.instantiate()
	space_node_main.add_child(new_node)
	return new_node
