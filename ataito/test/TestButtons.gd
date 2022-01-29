extends Node

## Path to the ARVR Controller
export (NodePath) var controller_left = null
export (NodePath) var controller_right = null

# Node references
var _controller_node_left: ARVRController = null
var _controller_node_right: ARVRController = null

var buttons_count := 15

var _pressed_left := Array()
var _pressed_right := Array()

func _ready():
	# Get the controller nodes
	_controller_node_left = get_node(controller_left) if controller_left else get_parent()
	_controller_node_right = get_node(controller_right) if controller_right else get_parent()

func _process(_delta):
	_process_controller("left", _controller_node_left, _pressed_left)
	_process_controller("right", _controller_node_right, _pressed_right)

func _process_controller(controller_name: String, controller: ARVRController, _pressed_already: Array):
	if !controller:
		return

	for i in range(buttons_count):
		var index = i+1
		var pressed = controller.is_button_pressed(index)
		var button_name = Function_Jump.Buttons.keys()[i]
		var print_info = {
			'controller': controller_name,
			'index': index,
			'button': button_name
		}

		if pressed and !_pressed_already.has(index):
			_pressed_already.append(index)
			print("{controller} {index} ({button}) pushed".format(print_info))
		elif !pressed and _pressed_already.has(index):
			_pressed_already.remove(_pressed_already.find(index))
			print("{controller} {index} ({button}) released".format(print_info))

