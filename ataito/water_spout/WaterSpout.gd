extends Spatial

onready var _sound := $Sound

func _ready():
	#change to blocked-up sound
	_sound.max_distance = 50
	_sound.pitch_scale = 0.5
	_sound.unit_db = 18

func _on_GrabDestroyBoulder_destroyed():
	$Spout.emitting = true
	$WindArea/CollisionShape.disabled = false

	#change to spraying sound
	_sound.max_distance = 70
	_sound.pitch_scale = 1
	_sound.unit_db = 50
