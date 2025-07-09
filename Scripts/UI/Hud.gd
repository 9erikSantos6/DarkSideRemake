extends CanvasLayer


var player1_integrity_bar
var player2_integrity_bar


func _ready() -> void:
	player1_integrity_bar = $IntegrityContainer/Player1/IntegrityBar
	player2_integrity_bar = $IntegrityContainer/Player2/IntegrityBar
	update_score(Game.get_player_stage_score())



func update_score(score: int) -> void:
	$Score.text = "SCORE: %d" % score


func update_player_integrity(game_type: Enums.PlayerType, live_value: float) -> void:
	if game_type == Enums.PlayerType.Player1:
		player1_integrity_bar.value = live_value
	elif game_type == Enums.PlayerType.Player2:
		player2_integrity_bar.value = live_value
