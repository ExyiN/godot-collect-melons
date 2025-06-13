extends Node2D

@export var melon_scene: PackedScene

@onready var melon_spawn_point: PathFollow2D = $MelonPath/MelonSpawnPoint
@onready var score_label: Label = $HUD/Score
@onready var health_container: HBoxContainer = $HUD/HealthContainer
@onready var player: Player = $Player
@onready var spawn_timer: Timer = $SpawnTimer

var score: int = 0

func _ready() -> void:
	health_container.add_hearts(player.current_health)
	
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
	else:
		player.take_damage()
		health_container.remove_heart()
		
func _on_player_no_health() -> void:
	spawn_timer.stop()
	get_tree().call_group("melons", "queue_free")
