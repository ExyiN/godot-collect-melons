class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State

func init(parent: Player) -> void:
	for child: State in get_children():
		child.parent = parent
	change_state(initial_state)

func process_input(event: InputEvent) -> void:
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)
		
func process_physics(delta: float) -> void:
	var new_state: State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
	
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
