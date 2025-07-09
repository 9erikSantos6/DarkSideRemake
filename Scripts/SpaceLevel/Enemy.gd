extends Area2D

@export var max_speed: float = 500.0
@export var min_speed: float = 255.0
@export var reward_points: int = 2
@export var punishiment_points: int = 5

var speed

var alive = false
var sprites
var screen_size = Game.screen_size

var sound_fx

func _ready():
	#randomize() # inicia o randomize
	sprites = [
		$sprite_enemy1,
		$sprite_enemy2,
		$sprite_enemy3,
		$sprite_enemy4
	]
	spawn()
	#var sond_fx = Global


func _physics_process(delta):
	control_move(delta)


func control_move(delta):
	var direction = Vector2(1, 0)
	global_position -= direction.normalized() * speed * delta


func spawn():
	speed = randf_range(255.0, 500.0)
	scale = Vector2(5,5)
	set_sprite()
	var texture = sprites[0].sprite_frames.get_frame_texture("default", 0)

	var sprite_width = texture.get_size().x

	var random_spawn_position = Vector2((screen_size.x + sprite_width * 2.5), randf_range(0, screen_size.y))
	global_position = random_spawn_position


func set_sprite():
	for sprite in sprites:
		sprite.visible = false
	var random_sprite = floor(randf_range(0, sprites.size()))
	sprites[random_sprite].visible = true


func _on_Enemy_area_entered(area):
	if area.is_in_group("player"):
		die()


func die():
	speed = 0
	sound_fx = Game.instace_sound_fx()
	sound_fx.play_audio('explosion', global_position)
	Game.set_player_stage_score(reward_points)
	alive = false
	queue_free()


func _exit_tree():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	Game.decrement_player_stage_score(punishiment_points)
	queue_free()
