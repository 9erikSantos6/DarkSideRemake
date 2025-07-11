extends Area2D

@export var max_speed: float = 500.0
@export var min_speed: float = 255.0
@export var reward_points: int = 2
@export var punishiment_points: int = 5
@export var damage_caused: int = 100

var speed

var explosion_scene = preload("res://Scenes/SpaceLevel/Elements/ExplosionEnemy.tscn")


var alive = false
var sprites
var screen_size = Game.screen_size

var sound_fx

func _ready():
	sprites = [
		$sprite_enemy1,
		$sprite_enemy2,
		$sprite_enemy3,
		$sprite_enemy4
	]
	spawn()
	sound_fx = Game.instance_sound_fx()


func _physics_process(delta):
	control_move(delta)


func control_move(delta):
	var direction = Vector2(1, 0)
	global_position -= direction.normalized() * speed * delta


func spawn():
	speed = randf_range(min_speed, max_speed)
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


func die_by_player_plasma():
	speed = 0
	sound_fx.play_audio('explosion', global_position)
	Game.set_player_stage_score(reward_points)
	
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	
	alive = false
	queue_free()

func die_by_collision():
	speed = 0
	sound_fx.play_audio('explosion', global_position)
	alive = false
	queue_free()


func _exit_tree():
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	Game.decrement_player_stage_score(punishiment_points)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.alive:
			body.take_damege(damage_caused)
			die_by_collision()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player's shot"):
		die_by_player_plasma()
