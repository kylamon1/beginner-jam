class_name Game
extends Node2D

const TILE_SIZE = 16

@export_file("*.tscn") var next_level
@onready var player: Player = $Player

func _ready() -> void:
	player.player_died.connect(_player_died)
	

func _player_died():
	
	$CanvasLayer/Panel.show()

func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()

func _on_win_area_body_entered(body: Node2D) -> void:
	body.in_win_area()
	$CanvasLayer/WinPanel.show()
	$Win.play()

func _on_next_level_pressed() -> void:
	if next_level != null:
		get_tree().change_scene_to_file(next_level)
