tool
extends Spatial

var mat_default : Material = preload("res://ataito/collectable/material/Default.material")
var mat_light : Material = preload("res://ataito/collectable/material/Light.material")
var mat_dark : Material = preload("res://ataito/collectable/material/Dark.material")

var pass_default : Mesh = preload("res://ataito/collectable/pass/pass_default.tres")
var pass_dark : Mesh = preload("res://ataito/collectable/pass/pass_dark.tres")

enum CollectType {
	Light = 1,
	Dark = 2
}

export (CollectType) var type := 0 setget _update_type

onready var _particles : Particles = $Particles

func _ready():
	_update_type(type)

func _update_type(value):
	type = value
	if !_particles:
		_particles = get_node_or_null("Particles")
	if !_particles:
		return

	match type:
		CollectType.Light:
			_particles.draw_pass_1 = pass_default
			_particles.process_material = mat_light
		CollectType.Dark:
			_particles.draw_pass_1 = pass_dark
			_particles.process_material = mat_dark
		_:
			_particles.draw_pass_1 = pass_default
			_particles.process_material = mat_default

