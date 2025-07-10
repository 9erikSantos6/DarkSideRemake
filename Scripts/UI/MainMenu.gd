extends Control

@export var fase_inicial: PackedScene = preload("res://Scenes/SpaceLevel/SpaceLevel.tscn")


func _on_start_btn_pressed() -> void:
	Game.game_mode = Enums.GameMode.SinglePlayer
	get_tree().change_scene_to_packed(fase_inicial)


func _on_muilt_btn_pressed() -> void:
	Game.game_mode = Enums.GameMode.MultiPlayer
	get_tree().change_scene_to_packed(fase_inicial)


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
