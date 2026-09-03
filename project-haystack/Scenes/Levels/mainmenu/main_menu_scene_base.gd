@tool
class_name MainMenuSceneBase
extends XRToolsSceneBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var xr_interface = XRServer.find_interface("OpenXR")
	#if xr_interface and xr_interface.is_initialized():
		## Check available refresh rates (returns an array like [72.0, 90.0, 120.0])
		#var rates = xr_interface.get_available_refresh_rates()
		#print("Available refresh rates: ", rates)
		#
		## Request 90Hz or 120Hz if supported
		#if 90.0 in rates:
			#xr_interface.requested_refresh_rate = 90.0
		#elif 120.0 in rates:
			#xr_interface.requested_refresh_rate = 120.0
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
