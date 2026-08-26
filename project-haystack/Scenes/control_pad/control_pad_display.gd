extends TabContainer

## Signal emitted when the control pad hand is switched.
signal switch_hand(hand)

## Signal emitted when the main menu button is pressed.
signal main_menu

## Signal emitted when the quit game button is pressed.
signal quit

## Signal emitted when the player wants to switch to the Feeding scene.
signal scene_switch_feeding

## Signal emitted when the player wants to switch to the Grooming scene.
signal scene_switch_grooming

@onready var label_node := %Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Have this here incase I want to update the screen display to display any live info.
# REMEMBER TO TURN OFF ONE SHOT if you need to use this timeout function.
func _on_refresh_timer_timeout() -> void:
	print("Control Pad Display Timer One-Shot Completed")

# Emitting the switch hand event set to the LEFT hand.
func _on_left_pressed() -> void:
	switch_hand.emit("LEFT")


# Emitting the switch hand event set to the RIGHT hand.
func _on_right_pressed() -> void:
	switch_hand.emit("RIGHT")

# Emitting the main menu event.
func _on_main_menu_pressed() -> void:
	main_menu.emit()

# Emitting the quit game event.
func _on_quit_pressed() -> void:
	quit.emit()

# Emitting the Feeding switch scene event.
func _on_feeding_pressed() -> void:
	scene_switch_feeding.emit()

# Emitting the Grooming switch scene event.
func _on_grooming_pressed() -> void:
	scene_switch_grooming.emit()
