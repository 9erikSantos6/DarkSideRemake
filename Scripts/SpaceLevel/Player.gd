extends Area2D

@export var speed: float = 850.0

var screen_size: Vector2

var plasma_scene = preload("res://Scenes/SpaceLevel/Elements/Plasma.tscn")


var player_index: int
var alife = false
var plasma_fired = false
var plasma_loaded = false
var sound


func _ready():
	screen_size = Game.screen_size
	spawn()


func _process(_delta):
	screen_size = Game.screen_size
	pass

func _physics_process(delta):
	control_player(delta)
	control_shot()


func spawn():
	player_index = Game.add_player(self)
	alife = true
	plasma_fired = false
	plasma_loaded = true
	scale = Vector2(5, 5)
	global_position = Vector2((0.14 * screen_size.x), (0.5 * screen_size.y))



func control_player(delta):
	if alife:
		var direction = Vector2.ZERO
		direction.x = int(Input.is_action_pressed("player_%s_move_right" % str(player_index))) - int(Input.is_action_pressed("player_%s_move_left" % str(player_index)))
		direction.y = int(Input.is_action_pressed("player_%s_move_down" % str(player_index))) - int(Input.is_action_pressed("player_%s_move_up" % str(player_index)))

		if direction.length() > 0:
			direction = direction.normalized() * speed
		global_position += direction * delta
		global_position.x = clamp(global_position.x, 0, screen_size.x)
		global_position.y = clamp(global_position.y, 0, screen_size.y)


func control_shot():
	if Input.is_action_pressed("player_%s_shoot" % str(player_index)) and plasma_loaded and alife:
		plasma_fired = true
		plasma_loaded = false
		instantiate_plasma(global_position)
		$reload_plasma.start()
		$plasma_shot.play()


func instantiate_plasma(position_plasma: Vector2):
	var plasma = plasma_scene.instantiate()
	plasma.add_player_parent(self)
	get_parent().add_child(plasma) # Corrigido aqui
	plasma.scale = Vector2(1, 1)
	plasma.global_position = Vector2(position_plasma.x, position_plasma.y)


func _on_reload_plasma_timeout():
	plasma_fired = false
	plasma_loaded = true


func die():
	alife = false
	# $ship_engines.stop() Desativado momentaneamente
	queue_free()


func _exit_tree():
	Game.player_nodes[player_index] = null
	alife = false
	plasma_fired = false
	plasma_loaded = false
	# $ship_engines.stop() Desativado momentaneamente
