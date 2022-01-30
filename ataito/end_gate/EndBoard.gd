extends Spatial

onready var time_tracker := $LevelTime

func _ready():
	pass # Replace with function body.

func stop_level_timer(_area):
	time_tracker.stop_time()
