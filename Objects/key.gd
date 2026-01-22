class_name Key
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.picked_up_key(self)
	$AudioStreamPlayer2D.play()
	$CollisionShape2D.set_deferred("disabled", true)
	call_deferred("reparent", body)
	global_position = body.global_position + Vector2(2, -8)
