extends Node2D

@export var galaxy_type: Global.GalaxysType = Global.GalaxysType.GalaxyA

var anim_sprite
var sprite_size
var sprite_width: float = 0.0  # inicializa com zero

var view_width = Global.screen_size.x
var view_height = Global.screen_size.y

func _ready() -> void:
	anim_sprite = $GalaxyAnimation
	var animation_name = str(galaxy_type)

	if anim_sprite.sprite_frames and anim_sprite.sprite_frames.has_animation(animation_name):
		var texture = anim_sprite.sprite_frames.get_frame_texture(animation_name, 0)
		sprite_size = texture.get_size()
		sprite_width = sprite_size.x
		anim_sprite.play(animation_name)
	else:
		push_warning("Animação '%s' não encontrada!" % animation_name)

func random_spawn_position() -> Vector2:
	var width = sprite_width if sprite_width != null else 0
	var random_vector = Vector2(
		view_width + width * 2.5,
		randf_range(0, view_height) + 200
	)
	return random_vector
