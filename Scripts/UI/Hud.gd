extends CanvasLayer


var player1_integrity_bar
var player2_integrity_bar


func _ready() -> void:
	player1_integrity_bar = $HBoxHud/IntegrityContainer/Player1/IntegrityBar
	player2_integrity_bar = $HBoxHud/IntegrityContainer/Player2/IntegrityBar

	set_visibility()
	update_score(Game.get_player_stage_score())


func update_score(score: int) -> void:
	$HBoxHud/VBoxScore/HBoxScore/Score.text = "SCORE: %d" % score


func update_player_integrity(player_type: Enums.PlayerType, life_value: float) -> void:
	if player_type == Enums.PlayerType.Player1:
		player1_integrity_bar.value = life_value
	elif player_type == Enums.PlayerType.Player2:
		player2_integrity_bar.value = life_value


func set_visibility():
	if Game.get_game_mode() == Enums.GameMode.SinglePlayer:
		get_node("HBoxHud/IntegrityContainer/Player2").visible = false
	else:
		get_node("HBoxHud/IntegrityContainer/Player2").visible = true
