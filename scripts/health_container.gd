extends HBoxContainer

@export var heart_scene: PackedScene

func add_hearts(number: int) -> void:
	for index: int in range(number):
		var heart: TextureRect = heart_scene.instantiate()
		add_child(heart)

func remove_heart() -> void:
	var child: TextureRect = get_child(0)
	if child:
		child.queue_free()
