extends Node3D#

@export var rotation_angle: int = 45: 
	set(new_value):
		rotation_angle = new_value

@onready var BSlider = %BrushSlider

enum BrushStates{
	START,
	GO_TO_MAX,
	GO_TO_MIN,
	debug
}

var state = BrushStates.START
var brush_grabbed: bool = false
var slider_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BSlider.released.connect(_on_brush_released)
	BSlider.grabbed.connect(_on_brush_grabbed)
	BSlider.slider_moved.connect(_on_slider_moved)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Make sure that its the player grabbing it, and not an external force moving it
	pass
	#if not brush_grabbed:
		#return
	
	
	
func _on_slider_moved(postion: Variant):
	slider_position = postion
	
	if BSlider.slider_position == BSlider.slider_limit_min \
	or \
	BSlider.slider_position == BSlider.slider_limit_max:
		print("You hit a limit")
		# Proof of concept rotation
		var tween = get_tree().create_tween()
		tween.tween_property($Brush, "rotation_degrees:z", $Brush.rotation_degrees.z + rotation_angle, 0.5)

func _on_brush_grabbed(_interactable: Variant):
	brush_grabbed = true

func _on_brush_released(_interactable: Variant):
	brush_grabbed = false
	# TODO: Clear the brushstate
	
