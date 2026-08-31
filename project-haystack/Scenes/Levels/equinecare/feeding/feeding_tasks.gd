extends Node3D

var sub_tasks_array : Array[Node]
var num_of_sub_tasks : int


var feeding_task_completed : String = "WELL DONE! You have completed the feeding task, you can return to the main menu or switch to a different level."

@onready var objective_info : ObjectivesInfo = get_tree().current_scene.find_child("ObjectivesInfo", true, false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sub_tasks_array = find_children("Task*")
	
	for task in sub_tasks_array:
		task = task as FeedingSubTask
		task.sub_task_completed.connect(_on_sub_task_completed)
	
	if not objective_info:
		push_error("Grooming_Tasks.gd could not find ObjectiveInfo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sub_task_completed() -> void:
	num_of_sub_tasks += 1
	
	if num_of_sub_tasks >= len(sub_tasks_array):
		objective_info.update_text(feeding_task_completed)
