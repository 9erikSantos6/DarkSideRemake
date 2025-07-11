extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.set_game_state(Enums.GameState.GameOver)

func _on_retry_btn_pressed() -> void:
	#var current_level = Game.set_current_level_scene(Game.get_current_level_type())
	get_tree().change_scene_to_file("res://Scenes/SpaceLevel/SpaceLevel.tscn")
	queue_free()

func _on_main_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
	queue_free()
	
func _on_quit_btn_pressed() -> void:
	get_tree().quit()
