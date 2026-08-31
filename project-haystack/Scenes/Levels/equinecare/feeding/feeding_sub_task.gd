class_name FeedingSubTask
extends Node3D

var bucket_snap_zone 

signal sub_task_completed

@onready var snap_zone : Node = find_child("FoodBucketSnapZone*") 

@onready var food_hint = find_child("FoodHint*") as Label3D
@onready var feeding_label = find_child("FeedingInfo*") as Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bucket_snap_zone = find_child("FoodBucketSnapZone*") as XRToolsSnapZone
	
	if bucket_snap_zone:
		bucket_snap_zone.has_picked_up.connect(_on_bucket_picked_up)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bucket_picked_up(_what: Variant) -> void:
	sub_task_completed.emit()
	
	# Turn off the visibility of the bucket and its snap zone m 
	_what.visible = false
	snap_zone.visible = false
	
	# Labels display
	feeding_label.visible = true
	food_hint.visible = false
	
	 
