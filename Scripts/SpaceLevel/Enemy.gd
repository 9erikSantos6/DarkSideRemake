extends Area2D

@export var max_speed: float = 500.0
@export var min_speed: float = 255.0
var speed

var alive = false 
var sprites
var screen_size = Global.screem_size

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
	if Global.node_game and Global.node_player:
		speed = randf_range(255.0, 500.0)
		scale = Vector2(5,5)
		set_sprite()
		var random_spawn_position = Vector2((screen_size.x + sprites[0].texture.get_width() * 2.5), randf_range(0, screen_size.y))
		global_position = random_spawn_position
	else:
		queue_free()
	
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
	sound_fx = Global.instace_sound_fx()
	sound_fx.play_audio('explosion', global_position)
	Global.node_game.player_pontuation += 5
	alive = false
	queue_free()
	
func _exit_tree():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
