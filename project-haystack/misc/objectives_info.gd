class_name ObjectivesInfo
extends Node

enum Levels {
	LEVEL_MAIN_MENU,
	LEVEL_FEEDING,
	LEVEL_GROOMING,
}

var objective_dict : Dictionary = {
	Levels.LEVEL_MAIN_MENU : " Main Menu:
		This is the main menu/hub area.
		Here, you can familiarise yourself with some of the environment and interactions present in the experience.
		When you are ready to move on, select a level from the Settings panel.",
	
	Levels.LEVEL_FEEDING : "Feeding Task:
		
		",
	
	Levels.LEVEL_GROOMING : "Grooming Task:
		- Each of the horses in the stable requires grooming. 
		- Interact with the brushes on the horses to begin grooming (some horses may have multiple brushes).
		- You must alternate your brush strokes to make progress.
		- Completing the grooming of a horse will provide you with a reason why grooming is important. The task is completed once all horses have been thoroughly groomed.",
}

## Text to be displayed on the control pad
signal display_objective(text : String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base := XRTools.find_xr_ancestor(
		self,
		"*",
		"XRToolsSceneBase") as XRToolsSceneBase
	
	# Return early if base cannot be found
	if not base:
		push_error("A valid XRToolsSceneBase was not found. Please make sure ObjectivesInfo is a child of a XRToolsSceneBase node")
		return
	
	# Find out which scene ObjectivesInfo is currently in and update the text accordingly
	if base is FeedingSceneBase:
		display_objective.emit(objective_dict[Levels.LEVEL_FEEDING])
	
	elif base is GroomingSceneBase:
		display_objective.emit(objective_dict[Levels.LEVEL_GROOMING])
		
	elif base is MainMenuSceneBase:
		display_objective.emit(objective_dict[Levels.LEVEL_MAIN_MENU])

## Function to use when wanting to force the text to update
func update_text(_text : String):
	display_objective.emit(_text)
