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
	if move_dir == 0 and (Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right")):
		return idle_state
	if move_dir != 0:
		parent.animations.flip_h = move_dir == -1
	parent.velocity.x = move_dir * parent.speed
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
