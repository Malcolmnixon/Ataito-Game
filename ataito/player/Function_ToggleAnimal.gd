tool
extends Node

## Optional path to the ARVR Controller
export (NodePath) var controller = null

# Controller node
var _controller_node : ARVRController = null

export (Function_DirectMovement.Buttons) var toggle_animal_button := Function_DirectMovement.Buttons.VR_BUTTON_BY
var _toggle_animal_button_pressed := false

var animal_parent: AnimalController = null

signal toggle_animal

func _ready():
	if Engine.editor_hint:
		return

	# Get the controller node
	_controller_node = get_node(controller) if controller else get_parent()

	#try to hook up to the parent
	animal_parent = get_parent() if get_parent() is AnimalController else get_parent().get_parent()
	connect("toggle_animal", animal_parent, "_toggle_animal")

func _process(_delta):
	if Engine.editor_hint or !controller:
		return
	var pressed = _controller_node.is_button_pressed(toggle_animal_button)
	if pressed and !_toggle_animal_button_pressed:
		emit_signal("toggle_animal")
	_toggle_animal_button_pressed = pressed

# This method verifies the ToggleAnimal has a valid configuration.
func _get_configuration_warning():
	# Check the controller node
	var test_controller_node = get_node_or_null(controller) if controller else get_parent()
	if !test_controller_node or !test_controller_node is ARVRController:
		return "Unable to find ARVR Controller node"

	# Passed basic validation
	return ""
