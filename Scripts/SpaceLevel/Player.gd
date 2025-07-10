extends CharacterBody2D

@export var speed: float = 850.0

var screen_size: Vector2
var plasma_scene = preload("res://Scenes/SpaceLevel/Elements/Plasma.tscn")

var player_index: int
var alive: bool = false
var plasma_fired: bool = false
var plasma_loaded: bool = false
var integrity: int = 100

var sound

func _ready():
	screen_size = Game.screen_size
	spawn()

func _physics_process(_delta):
	control_player()
	control_shot()

func spawn():
	player_index = Game.add_player(self)
	alive = true
	plasma_fired = false
	plasma_loaded = true

	global_position = Vector2(0.14 * screen_size.x, 0.5 * screen_size.y)


func control_player():
	if not alive:
		return

	var direction := Vector2.ZERO
	direction.x = Input.get_action_strength("player_%s_move_right" % player_index) - Input.get_action_strength("player_%s_move_left" % player_index)
	direction.y = Input.get_action_strength("player_%s_move_down" % player_index) - Input.get_action_strength("player_%s_move_up" % player_index)

	velocity = direction.normalized() * speed
	move_and_slide()
	detect_collision_with_enemy()

	global_position.x = clamp(global_position.x, 0, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)


func control_shot():
	if Input.is_action_pressed("player_%s_shoot" % str(player_index)) and plasma_loaded and alive:
		plasma_fired = true
		plasma_loaded = false
		instantiate_plasma(global_position)
		$reload_plasma.start()
		$plasma_shot.play()


func instantiate_plasma(position_plasma: Vector2):
	var plasma = plasma_scene.instantiate()
	plasma.add_player_parent(self)
	get_parent().add_child(plasma)
	plasma.scale = Vector2(1, 1)
	plasma.global_position = position_plasma


func detect_collision_with_enemy():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print(collision.get_collider().name)

func take_damege(amount):
	if amount > 0 and amount <= integrity and alive:
		integrity -= amount
		if integrity <= 0:
			die()

func die(atomize=false):
	alive = false
	# $ship_engines.stop() Desativado momentaneamente
	visible = false
	alive = false
	$PlayerCollisionShape.set_deferred("disabled", true)
	integrity = 0
	if atomize:	queue_free()

func _exit_tree():
	Game.player_nodes[player_index] = null
	alive = false
	plasma_fired = false
	plasma_loaded = false
	# $ship_engines.stop() Desativado momentaneamente

func _on_reload_plasma_timeout():
	plasma_fired = false
	plasma_loaded = true
