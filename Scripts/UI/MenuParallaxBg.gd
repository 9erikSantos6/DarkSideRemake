extends Node2D

@export var celestial_bodies_animated_sprite: PackedScene = preload("res://Prefabs/Space/CelestialBodyAnimationSprite.tscn")

var parallaxCelestialBody: Parallax2D

func _ready() -> void:
	parallaxCelestialBody = $NearbyCelestialBodies
	spawn_celestial_bodies(2)


func spawn_celestial_bodies(quantidade: int = 2) -> void:
	var repeat_width = parallaxCelestialBody.repeat_size.x
	if repeat_width <= 0:
		repeat_width = Game.screen_size.x * parallaxCelestialBody.repeat_times

	for i in range(quantidade):
		var body = celestial_bodies_animated_sprite.instantiate()
		body.body_type = randi_range(0, 4)
		var rand_scale = randi_range(1, 3)
		body.scale = Vector2(rand_scale, rand_scale)
		parallaxCelestialBody.add_child(body)

		var pos_x = (i + 0.5) * (repeat_width / quantidade)
		var pos_y = body.random_spawn_position().y
		body.position = Vector2(pos_x, pos_y)
