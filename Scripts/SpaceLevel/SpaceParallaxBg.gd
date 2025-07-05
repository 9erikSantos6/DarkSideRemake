extends Node2D

@export var animated_galaxy: PackedScene = preload("res://Scenes/SpaceLevel/Elements/AnimatedGalaxies.tscn")


func _ready() -> void:
	pass
	


func _on_galaxias_proximas_ready() -> void:
	var galaxy_a = animated_galaxy.instantiate()
	var galaxy_b = animated_galaxy.instantiate()
	var galaxy_c = animated_galaxy.instantiate()
	
	galaxy_a.galaxy_type = Global.GalaxysType.GalaxyA
	galaxy_b.galaxy_type = Global.GalaxysType.GalaxyB
	galaxy_c.galaxy_type = Global.GalaxysType.GalaxyC
	
	galaxy_a.position = galaxy_a.random_spawn_position()
	galaxy_a.position = galaxy_b.random_spawn_position()
	galaxy_a.position = galaxy_c.random_spawn_position()
	
	galaxy_a.scale = Vector2(4, 4)
	galaxy_b.scale = Vector2(5, 5)
	galaxy_c.scale = Vector2(1, 1)
	
	$GalaxiasProximas.add_child(galaxy_a)
	$GalaxiasProximas.add_child(galaxy_b)
	$GalaxiasProximas.add_child(galaxy_c)
