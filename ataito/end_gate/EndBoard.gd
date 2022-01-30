extends Spatial

onready var time_tracker := $LevelTime
onready var gate := get_parent()

signal level_ended

func stop_level_timer(_area):
	time_tracker.stop_time()
	emit_signal("level_ended")
