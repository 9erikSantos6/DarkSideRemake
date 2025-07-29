extends AnimatedSprite2D


@export var player_indicator: Enums.PlayerType = Enums.PlayerType.Player1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_select_indicator(str(player_indicator))


func _select_indicator(indicator_name):
	if sprite_frames and sprite_frames.has_animation(indicator_name):
		play(indicator_name)
	else:
		push_warning("Indicador de player '%s' não encontrado!" % indicator_name)
		visible = false

func set_player_indicator(player_type: Enums.PlayerType):
	player_indicator = player_type
