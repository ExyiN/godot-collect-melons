extends State

@export var fall_state: State
@export var jump_start_velocity: float = -600.0
@export var jump_gravity: float = 20.0

func enter() -> void:
	super()
	parent.velocity.y = jump_start_velocity
	
func process_physics(_delta: float) -> State:
	if Input.is_action_just_released("jump"):
		parent.velocity.y /= 2
	parent.velocity.y += jump_gravity
	if parent.velocity.y > 0:
		return fall_state

	var move_dir: float = Input.get_axis("move_left", "move_right")
	if move_dir != 0:
		parent.animations.flip_h = move_dir == -1
	parent.velocity.x = move_dir * parent.speed
	parent.move_and_slide()
	return null
