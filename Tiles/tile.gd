@tool
extends Area2D

@export var stable:= false
@export var time:= 2.0
@onready var tile: Sprite2D = $Sprite2D
var triggered = false

func _ready() -> void:
	if stable:
		modulate = Color(0.641, 1.0, 0.0, 1.0)

func _on_body_entered(body: Node2D) -> void:
	if not stable:
		var tw = create_tween()
		for i in range(time/0.2):
			tw.tween_property(tile, "position", Vector2(randi_range(-1, 1), randi_range(-1, 1)), 0.1)
			tw.tween_property(tile, "position", Vector2(0, 0), 0.1)
		tw.tween_callback(fall)
		tw.tween_property(tile, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
		
		
	
func fall():
	$CollisionShape2D.set_deferred("disabled", true)
	$KillArea/CollisionShape2D2.set_deferred("disabled", false)

func _on_kill_area_body_entered(body: Node2D) -> void:
	body.kill()
