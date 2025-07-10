extends Node

var screen_size: Vector2i

var soundFx_scene = preload("res://Scenes/SpaceLevel/SondFx/SoundFx.tscn")


var _player_overall_score: int = 0
var _player_score: int = 0
var player_nodes: Array[CharacterBody2D] = []

var game_mode: Enums.GameMode = Enums.GameMode.SinglePlayer

func _ready():
	randomize()
	screen_size = get_viewport().size


func _process(_delta: float) -> void:
	screen_size = get_viewport().size


func add_player(layer: CharacterBody2D) -> int:
	player_nodes.append(layer)
	return player_nodes.size() - 1


func instance_node(scene_name, parent):
	var new_node = scene_name.instantiate()
	parent.add_child(new_node)
	return new_node


func instance_node_in_position(scene_name, position, parent) -> Variant:
	var new_node = scene_name.instantiate()
	parent.add_child(new_node)
	new_node.global_position = position
	return new_node


func instace_sound_fx():
	var new_node = soundFx_scene.instantiate()
	add_child(new_node)
	return new_node


func get_player_stage_score() -> int:
	return _player_score

func reset_player_stage_score() -> void:
	_player_score = 0

func set_player_stage_score(score: int):
	if score > 0:
		_player_score += score
		_player_overall_score += _player_score
	return _player_score

func decrement_player_stage_score(score: int):
	if score > 0:
		_player_score -= score
		_player_overall_score -= _player_score
	if _player_score <= 0:
		_player_score = 0
	return _player_score

func get_player_overall_score() -> int:
	return _player_overall_score
