extends Node2D

@export var melon_scene: PackedScene

@onready var melon_spawn_point: PathFollow2D = $MelonPath/MelonSpawnPoint
@onready var score_label: Label = $HUD/Score

var score: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reload_scene"):
		get_tree().reload_current_scene()

func _on_spawn_timer_timeout() -> void:
	var melon: Area2D = melon_scene.instantiate()
	melon_spawn_point.progress_ratio = randf_range(0.1, 0.9)
	melon.position = melon_spawn_point.position
	melon.destroyed.connect(_on_melon_destroyed)
	add_child(melon)

func _on_melon_destroyed(is_player: bool) -> void:
	if is_player:
		score += 1
		score_label.text = str(score)
