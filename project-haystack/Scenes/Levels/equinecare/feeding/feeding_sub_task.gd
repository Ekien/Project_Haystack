class_name FeedingSubTask
extends Node3D

var bucket_snap_zone 

signal sub_task_completed


# Add labelssssssssssssss

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bucket_snap_zone = find_child("FoodBucketSnapZone*") as XRToolsSnapZone
	
	if bucket_snap_zone:
		bucket_snap_zone.has_picked_up.connect(_on_bucket_picked_up)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bucket_picked_up() -> void:
	sub_task_completed.emit()
	visible = false
