extends Node3D

@export var bucket_snap_zone: XRToolsSnapZone
var bucket_snap_avaliable: bool

var hay_amount: int = 0

@onready var hay_third: Node3D = $Hay_Third
@onready var hay_half: Node3D = $Hay_Half
@onready var hay_full: Node3D = $Hay_Full

enum hay_states {
	ONETHIRDFULL,
	HALFFULL,
	FULL
}

func update_bucket() -> void:
	match hay_amount:
		1:
			print("The bucket is one third full")
			hay_third.visible = true
			hay_half.visible = false
			hay_full.visible = false
		2:
			print("The bucket is half full")
			hay_third.visible = false
			hay_half.visible = true
			hay_full.visible = false
		3:
			print("The bucket is FULL!!!")
			hay_third.visible = false
			hay_half.visible = false
			hay_full.visible = true
			
	
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_bucket_snap_zone_has_picked_up(what: Variant) -> void:
	# Add to hay if first hay is being placed.
	if hay_amount == 0:
		hay_amount = 1
	elif hay_amount == 1:
		hay_amount = 2
	elif hay_amount == 2:
		hay_amount = 3
	else:
		print("NO MORE! IM FULL")
		
	update_bucket()
