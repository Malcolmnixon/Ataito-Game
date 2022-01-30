extends Spatial

onready var collectable_tracker = $CollectableTracker
onready var pedestal_light = $PedestalOfLight
onready var pedestal_dark = $PedestalOfDark

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

