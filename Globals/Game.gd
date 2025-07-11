extends Node

var screen_size: Vector2i

var soundFx_scene = preload("res://Scenes/SpaceLevel/SondFx/SoundFx.tscn")


var _player_overall_score: int = 0
var _player_score: int = 0
var _player_nodes: Array[CharacterBody2D] = []

var _game_mode: Enums.GameMode = Enums.GameMode.SinglePlayer

var _game_state: Enums.GameState = Enums.GameState.None

var game_levels: Array[PackedScene] = [
	preload("res://Scenes/SpaceLevel/SpaceLevel.tscn"),
]

var _current_level: Enums.GameLevels = Enums.GameLevels.SpaceLevel

func _ready():
	randomize()
	screen_size = get_viewport().size


func _process(_delta: float) -> void:
	screen_size = get_viewport().size


func add_player_node(layer: CharacterBody2D) -> int:
	if not layer.is_in_group("player"):
		push_error("The node is not in group 'player'.")
		return -1
	_player_nodes.append(layer)
	return _player_nodes.size() - 1

func remove_player_node(index: int) -> void:
	for p in _player_nodes.duplicate():
		if p.player_index == index:
			_player_nodes.erase(p)


func get_player_node(index: int) -> CharacterBody2D:
	if index < 0 or index >= _player_nodes.size():
		push_error("Invalid player index: %d" % index)
		return null
	return _player_nodes[index]


func get_player_nodes() -> Array[CharacterBody2D]:
	return _player_nodes


func instance_node(scene_pecked: PackedScene, parent):
	var new_node = scene_pecked.instantiate()
	parent.add_child(new_node)
	return new_node


func instance_node_in_position(scene_name, position, parent) -> Variant:
	var new_node = scene_name.instantiate()
	parent.add_child(new_node)
	new_node.global_position = position
	return new_node


func instance_sound_fx() -> Node2D:
	var new_node = soundFx_scene.instantiate()
	add_child(new_node)
	return new_node


func get_player_stage_score() -> int:
	return _player_score



func reset_player_stage_score() -> void:
	_player_score = 0



func set_player_stage_score(score: int) -> int:
	if score > 0:
		_player_score += score
		_player_overall_score += score
	return _player_score


func decrement_player_stage_score(score: int) -> int:
	if score > 0:
		_player_score -= score
		_player_overall_score -= score
	if _player_score < 0:
		_player_score = 0
	return _player_score


func get_player_overall_score() -> int:
	return _player_overall_score


func get_game_state() -> Enums.GameState:
	return _game_state


func set_game_state(state: Enums.GameState) -> void:
	if state < 0 or state >= Enums.GameState.size():
		push_error("Invalid game state: %d" % state)
		return
	_game_state = state


func get_current_level_type() -> Enums.GameLevels:
	return _current_level


func set_current_level_type(level: Enums.GameLevels) -> void:
	if level < 0 or level >= game_levels.size():
		push_error("Invalid stage index: %d" % level)
		return
	_current_level = level


func get_game_level_scene(game_level: Enums.GameLevels) -> PackedScene:
	if game_level < 0 or game_level >= game_levels.size():
		push_error("Invalid stage index: %d" % game_level)
		return null
	return game_levels[game_level]


func get_game_mode() -> Enums.GameMode:
	return _game_mode


func set_game_mode(mode: Enums.GameMode) -> void:
	if mode < 0 or mode >= Enums.GameMode.size():
		push_error("Invalid game mode: %d" % mode)
		return
	_game_mode = mode
