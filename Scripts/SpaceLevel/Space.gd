extends Node2D

@export var space_animation_velocity = 245.0
var space_texture1
var space_texture2
var space_largura
var screen_size = Global.screem_size

func _ready():
	init()

func _physics_process(delta):
	control_animation(delta)
	
func init():
	if Global.node_game:
		space_texture1 = $space_texture1
		space_texture2 = $space_texture2
		space_largura = space_texture1.texture.get_width()
		space_texture2.global_position.x = space_largura * 2
	else:
		queue_free()

func control_animation(delta):
	var taxa_movimento = space_animation_velocity * delta
	space_texture1.global_position.x -= taxa_movimento
	space_texture2.global_position.x -= taxa_movimento
	if space_texture1.global_position.x <= -space_largura * 2: 
		space_texture1.global_position.x = space_texture2.global_position.x + space_largura * 2 
	if space_texture2.global_position.x <= -space_largura * 2: 
		space_texture2.global_position.x = space_texture1.global_position.x + space_largura * 2 

func _exit_tree():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
