extends Node3D

var sub_tasks_array : Array[Node]
var num_of_sub_tasks : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sub_tasks_array = find_children("Task*")
	#print("The length of the array is ")
	#print(len(children_array))
	
	for task in sub_tasks_array:
		task = task as GroomingSubTask
		task.sub_task_completed.connect(_on_sub_task_completed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_sub_task_completed():
	num_of_sub_tasks += 1
	
	if num_of_sub_tasks >= len(sub_tasks_array):
		print("YOU HAVE FINISHED THE GROOMING TASK................WELL DONE!!!!!")
