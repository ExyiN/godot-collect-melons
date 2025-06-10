extends State

@export var fall_state: State

const MAX_JUMP_VELOCITY: float = -700.0
@export var jump_start_velocity: float = -500.0
@export var jump_velocity: float = -20.0
@export var jump_gravity: float = 50.0
var stop_jump: bool = false

func enter() -> void:
	super()
	stop_jump = false
	parent.velocity.y = jump_start_velocity
	
func process_physics(delta: float) -> State:
	if Input.is_action_just_released("jump") or parent.velocity.y <= MAX_JUMP_VELOCITY:
		stop_jump = true
	if Input.is_action_pressed("jump") and !stop_jump:
		parent.velocity.y += jump_velocity
	else:
		parent.velocity.y += jump_gravity
	if parent.velocity.y > 0:
		return fall_state

	var move_dir: float = Input.get_axis("move_left", "move_right")
	if move_dir != 0:
		parent.animations.flip_h = move_dir == -1
	parent.velocity.x = move_dir * parent.speed
	parent.move_and_slide()
	return null
