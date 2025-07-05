extends Node2D

@export var galaxy_animated_sprite: PackedScene = preload("res://Scenes/SpaceLevel/Elements/GalaxyAnimationSprite.tscn")

var parallaxGalaxies: Parallax2D

func _ready() -> void:
	parallaxGalaxies = $GalaxiasProximas
	spawn_galaxies()


func spawn_galaxies(quantidade: int = 2) -> void:
	var repeat_width = parallaxGalaxies.repeat_size.x
	if repeat_width <= 0:
		repeat_width = Global.screen_size.x * parallaxGalaxies.repeat_times

	for i in range(quantidade):
		var galaxy = galaxy_animated_sprite.instantiate()
		galaxy.galaxy_type = randi_range(0, 2)
		var rand_scale = randi_range(1, 4)
		galaxy.scale = Vector2(rand_scale, rand_scale)
		parallaxGalaxies.add_child(galaxy)
		
		var pos_x = (i + 0.5) * (repeat_width / quantidade)
		var pos_y = galaxy.random_spawn_position().y
		galaxy.position = Vector2(pos_x, pos_y)
