extends State

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump") and parent.is_on_floor():
		return jump_state
	return null

func process_physics(_delta: float) -> State:
	var move_dir: float = Input.get_axis("move_left", "move_right")
	if move_dir == 0:
		return idle_state
	parent.animations.flip_h = move_dir == -1
	parent.velocity.x = move_dir * parent.speed
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
