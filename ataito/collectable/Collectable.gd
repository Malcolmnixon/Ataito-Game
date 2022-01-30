tool
extends Spatial
class_name Collectable

var mat_default : Material = preload("res://ataito/collectable/material/Default.material")
var mat_light : Material = preload("res://ataito/collectable/material/Light.material")
var mat_dark : Material = preload("res://ataito/collectable/material/Dark.material")

var pass_default : Mesh = preload("res://ataito/collectable/pass/pass_default.tres")
var pass_dark : Mesh = preload("res://ataito/collectable/pass/pass_dark.tres")

enum Alignment {
	Light = 1,
	Dark = 2
}

export (Alignment) var type := Alignment.Light setget _update_type

onready var _object : Spatial = $Body
onready var _particles : Particles = $Body/Particles
onready var _pickup_sound : AudioStreamPlayer = $PickupSound

var _already_collected := false

signal collected(type, node)

func _ready():
	_object.connect("picked_up", self, "collect")
	_update_type(type)

func _update_type(value):
	type = value
	if !_particles:
		_particles = get_node_or_null("Particles")
	if !_particles:
		return

	match type:
		Alignment.Light:
			_particles.draw_pass_1 = pass_default
			_particles.process_material = mat_light
		Alignment.Dark:
			_particles.draw_pass_1 = pass_dark
			_particles.process_material = mat_dark
		_:
			_particles.draw_pass_1 = pass_default
			_particles.process_material = mat_default

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
