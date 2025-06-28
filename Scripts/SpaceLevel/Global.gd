extends Node

var soundFx_scene = preload("res://Scenes/SondFx/SoundFx.tscn")

var node_game = null
var node_player = null

var screem_size

func _ready():
	screem_size = get_viewport().size

func _process(_delta):
	screem_size = get_viewport().size
	
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
	node_game.add_child(new_node)
	return new_node
