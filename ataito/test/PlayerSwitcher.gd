extends Node

onready var _ape_player = preload("res://ataito/player/ape/ApePlayer.tscn")
onready var _bird_player = preload("res://ataito/player/bird/BirdPlayer.tscn")

var _timer: SceneTreeTimer = null
onready var _player: ARVROrigin = $Player
onready var _player_body: XRToolsPlayerBody = $Player/PlayerBody

var _toggle := false

# Called when the node enters the scene tree for the first time.
func _ready():
	_timer = get_tree().create_timer(5.0)
	_timer.connect("timeout", self, "switch_player")

func switch_player():
	# Save the current player transform and velocity
	var player_transform = _player.global_transform
	var player_velocity = _player_body.velocity

	yield(get_tree(), "physics_frame")

	# Destroy the old player
	remove_child(_player)
	_player.free()

	# Load the new player
	_player = _ape_player.instance() if _toggle else _bird_player.instance()
	_toggle = !_toggle

	_player_body = _player.get_node("PlayerBody")

	# Place the player
	_player.transform = player_transform
	_player_body.velocity = player_velocity

	add_child(_player)
