tool
extends Node

## Signal fired when the toogle animal button has been pressed
signal toggle_animal

## Optional path to the ARVR Controller
export (NodePath) var controller = null

## Button to trigger animal switching
export (Function_DirectMovement.Buttons) var toggle_animal_button := Function_DirectMovement.Buttons.VR_BUTTON_BY

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
