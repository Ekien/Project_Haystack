extends Node3D

# Levels
@export_group("Levels")
@export_file('*.tscn') var Feeding_Scene : String
@export_file('*.tscn') var Grooming_Scene : String

# The default hand to use is in the main staging scene.
var _staging : MainStaging

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the main staging scene
	_staging = XRTools.find_xr_ancestor(self, "*", "XRToolsStaging") as MainStaging
	
	# Connecting signals
	%Viewport2Din3D.connect_scene_signal("switch_hand", _on_switch_hand)
	%Viewport2Din3D.connect_scene_signal("main_menu", _on_main_menu)
	%Viewport2Din3D.connect_scene_signal("quit", _on_quit)
	%Viewport2Din3D.connect_scene_signal("scene_switch_feeding", _on_scene_switch_feeding)
	%Viewport2Din3D.connect_scene_signal("scene_switch_grooming", _on_scene_switch_grooming)
	
	# Set the location when everything is ready.
	_update_location.call_deferred()

# Handle switch hands of the control pad
func _on_switch_hand(hand : String) -> void:
	_staging.control_pad_hand = hand
	
	# Update the location of hand
	_update_location()

# Switch the player to the Feeding scene.
func _on_scene_switch_feeding() -> void:
	var base := XRTools.find_xr_ancestor(
		self,
		"*",
		"XRToolsSceneBase") as XRToolsSceneBase
	
	if base:
		base.load_scene(Feeding_Scene)

# Switch the player to the Grooming scene.
func _on_scene_switch_grooming() -> void:
	var base := XRTools.find_xr_ancestor(
		self,
		"*",
		"XRToolsSceneBase") as XRToolsSceneBase
	
	if base:
		base.load_scene(Grooming_Scene)


# Exit the player to the main menu
func _on_main_menu() -> void:
	# Get the base scene
	var base := XRTools.find_xr_ancestor(
		self,
		"*",
		"XRToolsSceneBase") as XRToolsSceneBase
	
	# Return to main scene if base scene is found
	if base:
		base.exit_to_main_menu()

# Let the player quit the game.
func _on_quit() -> void:
	# Get the base scene
	var base := XRTools.find_xr_ancestor(
		self,
		"*",
		"XRToolsSceneBase") as XRToolsSceneBase
	
	# Quit the game when base scene is found
	if base:
		base.quit()

# Update the location of this control pad
func _update_location() -> void:
	# Pick the location to set as our parent
	var location : ControlPadLocation
	if _staging.control_pad_hand == "LEFT":
		location = ControlPadLocation.find_left(self)
	else:
		location = ControlPadLocation.find_right(self)

	# Skip if no new location found
	if not location:
		return

	# Detach from current parent
	if get_parent():
		get_parent().remove_child(self)

	# Attach to new parent then zero our transform
	location.add_child(self)
	transform = Transform3D.IDENTITY
	visible = true
