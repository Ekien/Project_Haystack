@tool
class_name ControlPadLocation
extends Node3D

# THE IDEA FOR THE CONTROLPAD WAS HEAVILY INSPIRED BY THE GODOT XRTOOLS DEMO 

var _transform : Transform3D


func is_xr_class(name : String) -> bool:
	return name == "ControlPadLocation"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Grab the intial set transform 
	_transform = transform
	
	# Find the hand the control pad is connected to
	var hand := XRToolsHand.find_instance(self)
	if hand:
		# Connect to the hand scaling event
		hand.hand_scale_changed.connect(_on_hand_scale_changed)

# Handle world scale changing
func _on_hand_scale_changed(new_scale : float) -> void:
	# Scale the control pad
	transform = _transform.scaled(Vector3.ONE * new_scale)

## Find first instance to a ControlPadLocation related to a specified node
static func find_instance(node : Node) -> ControlPadLocation:
	return XRTools.find_xr_child(
		XRHelpers.get_xr_controller(node),
		# Pattern = Match to anything
		"*",
		"ControlPadLocation") as ControlPadLocation

## Find first instance to a LEFT ControlPadLocation related to a specified node
static func find_left(node : Node) -> ControlPadLocation:
	return XRTools.find_xr_child(
		XRHelpers.get_left_controller(node),
		# Pattern = Match to anything
		"*",
		"ControlPadLocation") as ControlPadLocation

## Find first instance to a RIGHT ControlPadLocation related to a specified node
static func find_right(node: Node) -> ControlPadLocation:
	return XRTools.find_xr_child(
		XRHelpers.get_right_controller(node),
		# Pattern = Match to anything
		"*",
		"ControlPadLocation") as ControlPadLocation
