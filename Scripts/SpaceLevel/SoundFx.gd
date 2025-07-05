extends Node2D

var audio_nodes = {}


func _ready():
	if Global.space_node_main:
		audio_nodes["explosion"] = $explosion
		# audio_nodes["ship_engines"] = $ship_engines Desativado momentaneamente
	else:
		queue_free()
		
func _process(_delta):
	pass


func play_audio(audio_name, target_position):
	if audio_name in audio_nodes:
		var audio_node = audio_nodes[audio_name]
		audio_node.global_position = target_position
		audio_node.play()


func stop_audio(audio_name):
	if audio_name in audio_nodes:
		var audio_node = audio_nodes[audio_name]
		audio_node.stop()


# calbacks de controle
func _on_explosion_finished():
	queue_free()


func _on_ship_engines_finished():
	queue_free()


func _on_SoundFx_tree_exited():
	queue_free()
# COMO GERENCIAR TODOS OS SONS???????
