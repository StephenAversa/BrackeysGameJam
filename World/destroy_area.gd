extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("destroy"):
		body.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("destroy"):
		area.get_parent().queue_free()
