class_name Player
extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var foot_steps: AudioStreamPlayer2D = $FootSteps

var moving := false
var target_position:Vector2
var speed = 0.3
var held_key:Area2D
var is_dead := false
var disabled:= false


signal player_died

func _ready() -> void:
	target_position = position

	
func _physics_process(_delta: float) -> void:
	if is_dead or disabled: return
	
	if not moving:
		if Input.is_action_pressed("right"):
			target_position = Vector2(position.x + Game.TILE_SIZE, position.y)
		elif Input.is_action_pressed("left"):
			target_position = Vector2(position.x - Game.TILE_SIZE, position.y)
		elif Input.is_action_pressed("up"):
			target_position = Vector2(position.x, position.y - Game.TILE_SIZE)
		elif Input.is_action_pressed("down"):
			target_position = Vector2(position.x, position.y + Game.TILE_SIZE)
		
		ray_cast.target_position = target_position - position
		ray_cast.force_raycast_update()
		
		if ray_cast.get_collider():
			target_position = position
		
		if target_position != position:
			moving = true
			foot_steps.pitch_scale = randf_range(-0.8, 1.2)
			foot_steps.play()
			var tw = create_tween()
			tw.tween_property(self, "position", target_position, speed)
			tw.tween_property(self, "moving", false, 0)

func picked_up_key(key):
	held_key = key
	speed *=2

func use_key() -> bool:
	if held_key:
		held_key.queue_free()
		speed /=2
		return true
	else:
		return false
	

func kill():
	is_dead = true
	$die.play()
	player_died.emit()
	var tw = create_tween()
	tw.tween_property(sprite, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.5)

func in_win_area():
	disabled = true
