extends Node

var soundFx_scene = preload("res://Scenes/SpaceLevel/SondFx/SoundFx.tscn")



var screen_size: Vector2 = Vector2.ZERO



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
	add_child(new_node)
	return new_node
