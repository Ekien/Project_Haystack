extends Node3D
class_name InteractableHorseGrooming

var brush_grabbed: bool = false
#var slider_position

@onready var BSlider = %BrushSlider

## The amount that will be progressed as a result of the player being successful.
@export_range(0.0, 1.0, 0.01) var progress: float = 0.1

## Angle to rotation the brush when one of the limits have been reached. Clamped between 10-90.
@export_range(10, 90) var rotation_angle: int = 45: 
	set(new_value):
		#new_value = clamp(new_value, 10, 90)
		rotation_angle = new_value

# TESTING POSSBILE WAYS TO CLAMP THE TWEEN TO ENSURE IT DOES NOT GO FUTHER THAN MIN OR MAX ROTATION
#@export var min_rotation: float = -45
#@export var max_rotation: float = 45

## Percentage chance for the brush to rotate each time a limit has been reached.
@export_range(0.0, 1.0, 0.01) var chance_to_rotate: float = .25:
	set(new_value):
		chance_to_rotate = new_value

enum BrushStates{
	START,
	GO_TO_MAX,
	GO_TO_MIN
}
var state : BrushStates

var brushing_completed : bool = false

signal made_progress(amount:float)
signal completed_brushing


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# CONNECTIONS
	BSlider.released.connect(_on_brush_released)
	BSlider.grabbed.connect(_on_brush_grabbed)
	BSlider.slider_moved.connect(_on_slider_moved)
	
	# Initialise the start state
	state = BrushStates.START
	
	# Initialise the progress bar
	%ProgressBar.value = %ProgressBar.min_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_slider_moved(_postion: Variant):
	# Return early if brushing has been completed
	if brushing_completed:
		return
		
	# This will allow the player to go either direction when they start.
	if state == BrushStates.START:
		if BSlider.slider_position == BSlider.slider_limit_min:
			state = BrushStates.GO_TO_MAX
			rotate_slider()
		elif BSlider.slider_position == BSlider.slider_limit_max:
			state = BrushStates.GO_TO_MIN
			rotate_slider()
	
	# Ensuring that the brush strokes are being alternated.
	if state == BrushStates.GO_TO_MAX and BSlider.slider_position == BSlider.slider_limit_max:
		rotate_slider()
		
		state = BrushStates.GO_TO_MIN

	elif state == BrushStates.GO_TO_MIN and BSlider.slider_position == BSlider.slider_limit_min:
		rotate_slider()
		
		state = BrushStates.GO_TO_MAX



func rotate_slider() -> void:
	progress_emit()
	if rotate_check():
		var duration: float = 0.25
		
		var final_val: float
		final_val = randf_range(-rotation_angle, rotation_angle)
		
		# TESTING POSSBILE WAYS TO CLAMP THE TWEEN TO ENSURE IT DOES NOT GO FUTHER THAN MIN OR MAX ROTATION
		#var difference: float 
		#if $Brush.rotation_degrees.z + final_val >= max_rotation:
			#difference =  $Brush.rotation_degrees.z + final_val - max_rotation
			#final_val = difference
		
		var tween = get_tree().create_tween()
		tween.tween_property($Brush, "rotation_degrees:z", $Brush.rotation_degrees.z + final_val, duration)



func rotate_check() -> bool:
	var rand_float: float = randf()
	var chance: float  = snappedf(rand_float, 0.01)

	if chance <= chance_to_rotate:
		return true
		
	return false


func _on_brush_grabbed(_interactable: Variant):
	brush_grabbed = true

func _on_brush_released(_interactable: Variant):
	brush_grabbed = false
	state = BrushStates.START

# Emit the progress the player has made
func progress_emit() -> void:
	made_progress.emit(progress)

func _on_made_progress(_amount: float) -> void:
	#print("PROGRESS HAS BEEN MADE " + str(_amount))
	
	# Only increment if the brushing has not be completed yet.
	if brushing_completed:
		# Return early.
		return
	
	# Increment the progress
	%ProgressBar.value = %ProgressBar.value + progress

	if %ProgressBar.value >= %ProgressBar.max_value:
		brushing_completed = true
		completed_brushing.emit()


func end_brushing():
	# TODO: Add all effects and signal emissions before removing
	
	# Delete the brush from the scene
	queue_free()
