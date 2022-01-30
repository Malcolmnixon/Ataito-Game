tool
extends Spatial
class_name Collectable

enum Alignment {
	Light = 1,
	Dark = 2
}

export (Alignment) var type := Alignment.Light setget _update_type, _get_type

onready var _object : Spatial = $Body
onready var _particles : Particles = $Body/SpiritOrb
onready var _pickup_sound : AudioStreamPlayer = $PickupSound

var _already_collected := false

signal collected(type, node)

func _ready():
	_object.connect("picked_up", self, "collect")
	_update_type(type)

func _get_type():
	return _particles.type

func _update_type(value):
	if !_particles:
		_particles = get_node_or_null("Particles")
	if !_particles:
		return

	_particles.update_type(type)

func collect(source: XRToolsPickable):
	if _already_collected:
		return
	emit_signal("collected", type, self)
	#visible = false
	_already_collected = true
	#source.drop_and_free()
	_particles.emitting = false
	#_pickup_sound.connect("finished", self, "queue_free")
	_pickup_sound.play_sfx()
