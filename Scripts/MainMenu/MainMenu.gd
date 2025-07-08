extends Control


@export var fase_inicial: PackedScene = preload("res://Scenes/SpaceLevel/SpaceLevel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_packed(fase_inicial)


func _on_quit_btn_pressed() -> void:
	pass # Replace with function body.


func _on_muilt_btn_pressed() -> void:
	pass # Replace with function body.
