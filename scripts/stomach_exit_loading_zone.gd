extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and GlobalTilemap.tilemap:
		GlobalTilemap.tilemap.set_cell(Vector2i(2, 4), 0, Vector2i.ZERO, 2)
		GlobalTilemap.tilemap.set_cell(Vector2i(1, 5), 0, Vector2i.ZERO, 9)
		GlobalTilemap.tilemap.set_cell(Vector2i(1, 4))
		GlobalTilemap.tilemap.set_cell(Vector2i(0, 4))
