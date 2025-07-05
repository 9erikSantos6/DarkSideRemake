extends Area2D

@export var speed: float = 3300

var fired = Global.node_player.plasma_fired

func _ready():
	spawn()


func _physics_process(delta):
	control_move(delta)


func spawn():
	if Global.node_game == get_parent():
		scale = Vector2(5,5)
	elif Global.node_player == get_parent():
		pass
	else:
		queue_free()


func control_move(delta):
	if fired:
		var direction = Vector2(1,0)
		direction = direction.normalized() * speed * delta
		global_position += direction


func _on_Plasma_area_entered(_area):
	collide()


func collide():
	speed = 0
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
