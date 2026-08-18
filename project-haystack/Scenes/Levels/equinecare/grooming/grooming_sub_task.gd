extends Node3D
class_name GroomingSubTask


var horse_grooming_tasks : Array[Node]
var timer : Node
var label : Node


var num_of_brushes_completed : int = 0

signal sub_task_completed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Store all the brushing nodes that are a children of this task
	horse_grooming_tasks = find_children("InteractableHorseGrooming*")
	#print("The length of brush tasks in %s is ", str(self))
	#print(len(horse_grooming_tasks)) 
	
	if len(horse_grooming_tasks) == 0:
		push_error("PLEASE ENSURE THAT THERE IS A LEAST ONE GROOMING BRUSH IN EACH SUBTASK")
	else:
		for task in horse_grooming_tasks:
			task = task as InteractableHorseGrooming
			task.completed_brushing.connect(_on_completed_brushing)
	
	
	label = find_child("Reasons*") as Label3D
	if not label:
		push_error("Reasons for Horse Grooming text could not be found or is not a Label3D")
	
	# Timer to be used for the visibility of the Reasons for Grooming text
	timer = find_child("ReasonsTimer*") as Timer
	if timer:
		timer.timeout.connect(_on_timeout)
	else:
		push_error("ReasonsTimer could not be found or is not a timer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout():
	label.visible = false


func _on_completed_brushing():
	num_of_brushes_completed += 1
	
	if num_of_brushes_completed >= len(horse_grooming_tasks):
		label.visible = true
		timer.start()
		sub_task_completed.emit()

	
