tool
extends Node

## Signal fired when the toogle animal button has been pressed
signal toggle_animal

enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}

## Optional path to the ARVR Controller
export (NodePath) var controller = null

## Button to trigger animal switching
export (Buttons) var toggle_animal_button := Buttons.VR_BUTTON_BY

# Controller node
var _controller_node : ARVRController = null

var _toggle_pressed := false

func _ready():
	if Engine.editor_hint:
		return

	# Get the controller node
	_controller_node = get_node(controller) if controller else get_parent()

func _process(_delta):
	# Skip if in editor, or no controller
	if Engine.editor_hint or !_controller_node:
		return

	# Detect toggle-button pressed
	var old_toggle_pressed = _toggle_pressed
	_toggle_pressed = _controller_node.is_button_pressed(toggle_animal_button)

	# On press, report signal
	if _toggle_pressed and !old_toggle_pressed:
		emit_signal("toggle_animal")

# This method verifies the ToggleAnimal has a valid configuration.
func _get_configuration_warning():
	# Check the controller node
	var test_controller_node = get_node_or_null(controller) if controller else get_parent()
	if !test_controller_node or !test_controller_node is ARVRController:
		return "Unable to find ARVR Controller node"

	# Passed basic validation
	return ""
