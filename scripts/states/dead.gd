extends State

func enter() -> void:
	super()
	await parent.animations.animation_finished
	parent.hide()
