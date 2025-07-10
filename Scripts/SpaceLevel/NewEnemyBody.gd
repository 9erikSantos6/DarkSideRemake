extends CharacterBody2D

@export var max_speed: float = 500.0
@export var min_speed: float = 255.0
@export var reward_points: int = 2
@export var punishiment_points: int = 5

var speed: float
var alive: bool = false
var sprites: Array
var screen_size: Vector2 = Game.screen_size

var sound_fx

func _ready() -> void:
	sprites = [
		$sprite_enemy1,
		$sprite_enemy2,
		$sprite_enemy3,
		$sprite_enemy4
	]
	spawn()

func _physics_process(delta: float) -> void:
	control_move(delta)

func control_move(_delta: float) -> void:
	if alive:
		velocity = Vector2(-speed, 0)
		move_and_slide()

func spawn() -> void:
	alive = true
	speed = randf_range(min_speed, max_speed)
	scale = Vector2(5, 5)
	set_sprite()

	var texture = sprites[0].sprite_frames.get_frame_texture("default", 0)
	var sprite_width = texture.get_size().x
	var random_spawn_position = Vector2((screen_size.x + sprite_width * 2.5), randf_range(0, screen_size.y))
	global_position = random_spawn_position

func set_sprite() -> void:
	for sprite in sprites:
		sprite.visible = false
	var random_sprite = floor(randf_range(0, sprites.size()))
	sprites[random_sprite].visible = true

func die_by_player_plasma() -> void:
	velocity = Vector2.ZERO
	alive = false
	sound_fx = Game.instace_sound_fx()
	sound_fx.play_audio("explosion", global_position)
	Game.set_player_stage_score(reward_points)
	queue_free()

func die_by_collision() -> void:
	velocity = Vector2.ZERO
	alive = false
	sound_fx = Game.instace_sound_fx()
	sound_fx.play_audio("explosion", global_position)
	queue_free()

func _exit_tree() -> void:
	queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	Game.decrement_player_stage_score(punishiment_points)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		die_by_collision()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player's shot"):
		die_by_player_plasma()
