extends Area2D


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("set_underwater_mode"):
		body.set_underwater_mode(true)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("set_underwater_mode"):
		body.set_underwater_mode(false)
