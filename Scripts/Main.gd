extends Node

func _ready() -> void:
	call_deferred("_go_to_main_menu")

func _go_to_main_menu():
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func close_game():
	get_tree().quit()
