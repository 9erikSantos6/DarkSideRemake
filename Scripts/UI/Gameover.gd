extends CanvasLayer

#var main_menu_scene = preload("res://UI/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.set_game_state(Enums.GameState.GameOver)

func _on_retry_btn_pressed() -> void:
	#var current_level = Game.set_current_level_scene(Game.get_current_level_type())
	get_tree().change_scene_to_file("res://Scenes/SpaceLevel/SpaceLevel.tscn")
	queue_free()

func _on_main_menu_btn_pressed() -> void:
	#
	#queue_free()
	#var main = main_menu_scene.instantiate()
	#get_tree().root.add_child()
	#queue_free()
	#get_tree().change_scene_to_packed(main_menu_scene)
	pass
	
func _on_quit_btn_pressed() -> void:
	get_tree().quit()
