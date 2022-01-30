extends Spatial

export var restart_timer := 10.0

onready var collectable_tracker = $CollectableTracker
onready var pedestal_light = $PedestalOfLight
onready var pedestal_dark = $PedestalOfDark
onready var celebrate_particles = $CelebrationParticles

# Called when the node enters the scene tree for the first time.
func _ready():
	collectable_tracker.connect("total_updated", self, "_update_pedestals")

func _update_pedestals(_amount, _total):
	var light_orbs = pedestal_light.get_children()
	for orb in light_orbs:
		orb.emitting = int(orb.name) <= collectable_tracker.collected_light

	var dark_orbs = pedestal_dark.get_children()
	for orb in dark_orbs:
		orb.emitting = int(orb.name) <= collectable_tracker.collected_dark

func _on_level_ended():
	celebrate_particles.emitting = true
	
	# Don't allow the player to collect more orbs after stopping the timer
	var collectables = get_tree().get_nodes_in_group("collectable")
	for c in collectables:
		c._already_collected = true
		c._orb.emitting = false
		
	# Wait for the timer
	yield(get_tree().create_timer(restart_timer), "timeout")

	# Reload the level
	get_tree().change_scene("res://ataito/level/Level.tscn")
