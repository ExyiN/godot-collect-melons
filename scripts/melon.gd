extends Area2D

signal destroyed(is_player: bool)

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var collected: bool = false

func _ready() -> void:
	animation.play("default")

func _physics_process(delta: float) -> void:
	var speed: float = 50.0
	position.y += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player and !collected:
		collected = true
		animation.play("collected")
		await animation.animation_finished
	destroyed.emit(collected)
	queue_free()
