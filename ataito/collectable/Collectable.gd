tool
extends Spatial
class_name Collectable

export (SpiritOrb.Alignment) var type := SpiritOrb.Alignment.Light setget _update_type, get_type

onready var _object : Spatial
onready var _orb : Particles
onready var _pickup_sound : AudioStreamPlayer = $PickupSound

var _already_collected := false

signal collected(type, node)

func _ready():
	ensure_variables()
	_update_type(type)
	if !Engine.editor_hint:
		# warning-ignore:return_value_discarded
		_object.connect("picked_up", self, "collect")

func ensure_variables():
	if !_object:
		_object = get_node_or_null("Body")
	if !_orb:
		_orb = _object.get_node_or_null("SpiritOrb")

func get_type():
	ensure_variables()
	return _orb.type

func _update_type(value):
	ensure_variables()
	type = value
	_orb.type = type

func collect(_source: XRToolsPickable):
	if _already_collected:
		return
	emit_signal("collected", type, self)
	_already_collected = true
	_orb.emitting = false
	_pickup_sound.play_sfx()
