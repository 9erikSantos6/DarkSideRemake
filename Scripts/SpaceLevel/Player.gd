extends Area2D

@export var speed: float = 850.0

var screen_size = Global.screen_size

var plasma_scene = preload("res://Scenes/SpaceLevel/Elements/Plasma.tscn")

var alife = false
var plasma_fired = false
var plasma_loaded = false
var sound

func _ready():
	spawn()


func _physics_process(delta):
	control_player(delta)
	control_shot()


func spawn():
	if Global.space_node_main:
		Global.node_player = self
		alife = true
		plasma_fired = false
		plasma_loaded = true
		scale = Vector2(5, 5)
		global_position = Vector2((0.14 * screen_size.x), (0.5 * screen_size.y))
		#$ship_engines.play() Desativado momentaneamente
	else:
		queue_free()


func control_player(delta):
	if alife:
		var direction = Vector2.ZERO
		direction.x = int(Input.is_action_pressed("player_move_right")) - int(Input.is_action_pressed("player_move_left"))
		direction.y = int(Input.is_action_pressed("player_move_down")) - int(Input.is_action_pressed("player_move_up"))
		if direction.length() > 0:
			direction = direction.normalized() * speed
		global_position += direction * delta
		global_position.x = clamp(global_position.x, 0, screen_size.x)
		global_position.y = clamp(global_position.y, 0, screen_size.y)


func control_shot():
	if Input.is_action_pressed("player_shoot") and plasma_loaded and alife:
		plasma_fired = true
		plasma_loaded = false
		Global.instance_node_in_position(plasma_scene, global_position, Global.space_node_main)
		$reload_plasma.start()
		$plasma_shot.play()



func _on_reload_plasma_timeout():
	plasma_fired = false
	plasma_loaded = true


func die():
	alife = false
	# $ship_engines.stop() Desativado momentaneamente
	queue_free()


func _exit_tree():
	Global.node_player = null
	alife = false
	plasma_fired = false
	plasma_loaded = false
	# $ship_engines.stop() Desativado momentaneamente
	queue_free()
