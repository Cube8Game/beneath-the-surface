extends Node2D


@onready var player: CharacterBody2D = $Player

var cheat_code = "NOLIMITS"
var cheat_code_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTilemap.tilemap = $TileMapLayer

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.echo or event.is_released():
			return
		var key: InputEventKey = event
		if key.as_text_keycode().to_upper() == cheat_code[cheat_code_progress]:
			cheat_code_progress += 1
		else:
			cheat_code_progress = 0
		if cheat_code_progress >= len(cheat_code):
			player.cheat_mode = not player.cheat_mode
			player.get_node("ColorRect").visible = not player.cheat_mode
			player.get_node("ColorRect2").visible = not player.cheat_mode
			player.get_node("Camera2D").zoom = Vector2.ONE * (0.25 if player.cheat_mode else 1.0)
			cheat_code_progress = 0
