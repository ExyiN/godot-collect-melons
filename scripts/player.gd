class_name Player
extends CharacterBody2D

signal no_health()

@export var MAX_HEALTH: int = 3
@export var dead_state: State

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine

var speed: float = 200.0
var last_direction: float = 1.0
var current_health: int

func _ready() -> void:
	state_machine.init(self)
	current_health = MAX_HEALTH

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func take_damage() -> void:
	current_health -= 1
	if current_health <= 0:
		no_health.emit()
		state_machine.change_state(dead_state)
	animation_player.play("hit")
