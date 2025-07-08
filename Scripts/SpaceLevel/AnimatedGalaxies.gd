extends AnimatedSprite2D

@export var galaxy_type: Enums.GalaxysType = Enums.GalaxysType.GalaxyA

var anim_sprite: AnimatedSprite2D
var sprite_width: float = 0.0

var screen_size: Vector2 = Game.screen_size


func _ready() -> void:

	var animation_name = str(galaxy_type)

	var texture = sprite_frames.get_frame_texture(animation_name, 0)
	sprite_width = texture.get_size().x

	_select_animation(animation_name)


func random_spawn_position() -> Vector2:
	var parallax_node = get_parent()
	var repeat_size_x = screen_size.x
	if parallax_node:
		repeat_size_x = parallax_node.repeat_size.x

	var effective_width = sprite_width * scale.x
	var spawn_x = randf_range(0, repeat_size_x - effective_width)
	var spawn_y = randf_range(0, screen_size.y)

	return Vector2(spawn_x, spawn_y)


func get_real_width() -> float:
	if sprite_frames:
		var animation_name = str(galaxy_type)
		var texture = sprite_frames.get_frame_texture(animation_name, 0)
		if texture:
			return texture.get_size().x * scale.x
	return 0.0


func random_spawn():
	position = random_spawn_position()
	visible = true

func spawn():
	visible = true

func _select_animation(animation_name):
	if sprite_frames and sprite_frames.has_animation(animation_name):
		play(animation_name)
	else:
		push_warning("Animação '%s' não encontrada!" % animation_name)
		visible = false
