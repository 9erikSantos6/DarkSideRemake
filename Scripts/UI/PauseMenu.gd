extends CanvasLayer


#var main_menu_scene = preload("res://UI/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass


func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	Game.set_game_state(Enums.GameState.Playing)
	queue_free()


func _on_gamemenu_btn_pressed() -> void:
	get_tree().paused = false
	#get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
	#queue_free()
	
	#call_deferred("change_to_main")
	get_tree().quit()


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
	


#func change_to_main():
	#var gameover_screen = main_menu_scene.instantiate()
	#get_tree().root.add_child(gameover_screen)
	#queue_free()
