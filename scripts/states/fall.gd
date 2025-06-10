extends State

@export var idle_state: State
@export var run_state: State
@export var fall_gravity: float =  400.0

func process_physics(_delta: float) -> State:
	parent.velocity.y = fall_gravity
	
	var move_dir: float = Input.get_axis("move_left", "move_right")
	if move_dir != 0:
		parent.animations.flip_h = move_dir == -1
	parent.velocity.x = move_dir * parent.speed
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if move_dir == 0:
			return idle_state
		return run_state
	return null
