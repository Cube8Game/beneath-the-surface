extends Area2D


var overlapping_bodies = []

func _physics_process(_delta: float) -> void:
	#for body in bodies
	overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.has_method("set_underwater_mode"):
			body.set_underwater_mode(false)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("set_underwater_mode"):
		body.set_underwater_mode(true)
