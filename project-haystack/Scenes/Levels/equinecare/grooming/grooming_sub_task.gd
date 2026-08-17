extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var horse_grooming_tasks = find_children("InteractableHorseGrooming*")
	print("The length of brush tasks in %s is ", str(self))
	print(len(horse_grooming_tasks)) 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
