@tool
class_name MainStaging
extends XRToolsStaging

# Initial value that'll be used when placing the control hand.
var control_pad_hand : String = "LEFT"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
