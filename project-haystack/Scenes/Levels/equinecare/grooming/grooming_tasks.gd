extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children_array = find_children("Task*")
	print("The length of the array is ")
	print(len(children_array))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
