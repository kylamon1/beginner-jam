extends StaticBody2D
@onready var sprite: Sprite2D = $Sprite2D

func _on_unlock_area_body_entered(body: Node2D) -> void:
	if body.use_key():
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.set_deferred("disabled", true)
		var tw = create_tween().set_parallel()
		tw.tween_property(sprite, "position", sprite.position + Vector2(0, -Game.TILE_SIZE), 0.5)
		tw.tween_property(sprite,  "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.3)
