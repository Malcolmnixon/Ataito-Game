tool
extends Particles
class_name SpiritOrb

var mat_default : Material = preload("res://ataito/collectable/material/Default.material")
var mat_light : Material = preload("res://ataito/collectable/material/Light.material")
var mat_dark : Material = preload("res://ataito/collectable/material/Dark.material")

var pass_default : Mesh = preload("res://ataito/collectable/pass/pass_default.tres")
var pass_dark : Mesh = preload("res://ataito/collectable/pass/pass_dark.tres")

enum Alignment {
	Light = 1,
	Dark = 2
}

export (Alignment) var type := Alignment.Light setget set_type

func _ready():
	if type == Alignment.Dark:
		set_type(type)

func set_type(value):
	type = value
	match type:
		Alignment.Light:
			draw_pass_1 = pass_default
			process_material = mat_light
		Alignment.Dark:
			draw_pass_1 = pass_dark
			process_material = mat_dark
		_:
			draw_pass_1 = pass_default
			process_material = mat_default
