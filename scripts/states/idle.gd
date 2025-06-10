extends State

@export var jump_state: State
@export var run_state: State
@export var fall_state: State

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump") and parent.is_on_floor():
		return jump_state
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		return run_state
	return null
	
func process_physics(_delta: float) -> State:
	if !parent.is_on_floor():
		return fall_state
	return null
