extends Node3D

@export var bucket_snap_zone: XRToolsSnapZone
var bucket_snap_avaliable: bool

# ADD ITEM TO DROP AS A VARIABLE (in this case hay)
@export var Item_To_Drop : PackedScene

var hay_amount: int = 0

@onready var hay_third: Node3D = $Hay_Third
@onready var hay_half: Node3D = $Hay_Half
@onready var hay_full: Node3D = $Hay_Full

@onready var root = $".."

enum hay_states {
	EMPTY,
	ONETHIRDFULL,
	HALFFULL,
	FULL
}

var num_of_hay : Dictionary = {
	hay_states.ONETHIRDFULL : 1,
	hay_states.HALFFULL : 2,
	hay_states.FULL : 3,
}

var state = hay_states.EMPTY

func update_bucket() -> void:
	match hay_amount:
		1:
			# print("The bucket is one third full")
			hay_third.visible = true
			hay_half.visible = false
			hay_full.visible = false
			# Place in correct group
			root.add_to_group("Bucket_Third_Full")
			
			# Set the state
			state = hay_states.ONETHIRDFULL
		2:
			# print("The bucket is half full")
			hay_third.visible = false
			hay_half.visible = true
			hay_full.visible = false
			# Place in correct group
			root.remove_from_group("Bucket_Third_Full")
			root.add_to_group("Bucket_Half_Full")
			
			# Set the state
			state = hay_states.HALFFULL
		3:
			# print("The bucket is FULL!!!")
			hay_third.visible = false
			hay_half.visible = false
			hay_full.visible = true
			# Place in correct group
			root.remove_from_group("Bucket_Half_Full")
			root.add_to_group("Bucket_Full")
			
			# Set the state
			state = hay_states.FULL
			$BucketSnapZone.enabled = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Viewport2Din3D.connect_scene_signal("clear_pressed", _on_clear_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_clear_button_pressed() -> void:
	# Return early if bucket is empty
	if state == hay_states.EMPTY:
		return

	# Spawn the correct number of hay
	for i in num_of_hay[state]:
		var hay = Item_To_Drop.instantiate()
	
		get_tree().current_scene.add_child(hay)
		
		var offset := Vector3(
			randf_range(0.4, 0.9),
			0,
			0
		)
		
		hay.global_position = global_transform * offset
	
	# Resetting bucket
	state = hay_states.EMPTY
	hay_third.visible = false
	hay_half.visible = false
	hay_full.visible = false
	root.remove_from_group("Bucket_Third_Full")
	root.remove_from_group("Bucket_Half_Full")
	root.remove_from_group("Bucket_Full")
	$BucketSnapZone.enabled = true
	hay_amount = 0

func _on_bucket_snap_zone_has_picked_up(_what: Variant) -> void:
	if not hay_amount < 3:
		print("NO MORE! IM FULL")
		return
		
	# Add to hay if first hay is being placed.
	hay_amount += 1;
	
	# Delete the hay from the snap zone before updating the bucket 
	_what.queue_free()
	
	update_bucket()
