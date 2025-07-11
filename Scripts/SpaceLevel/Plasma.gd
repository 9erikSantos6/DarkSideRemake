extends Area2D

@export var speed: float = 3300

var parent_index: int
var fired: bool

func _ready():
	spawn()


func _physics_process(delta):
	move(delta)


func spawn():
	scale = Vector2(0.1, 0.1)
	if parent_index >= 0 and parent_index < Game.get_player_nodes().size():
		fired = Game.get_player_node(parent_index).plasma_fired
	else:
		fired = false

func move(delta):
	if fired:
		var direction = Vector2(1,0)
		direction = direction.normalized() * speed * delta
		global_position += direction


func _on_Plasma_area_entered(_area):
	collide()


func collide():
	speed = 0
	queue_free()


func add_player_parent(player: CharacterBody2D):
	if player and player.is_in_group("player"):
		parent_index = player.player_index
		fired = true
	else:
		fired = false


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
