extends Label

onready var collectable_tracker = get_parent().get_parent().get_node("CollectableTracker")
onready var time_tracker = get_parent().get_parent().get_node("LevelTime")

var _timer = null

func _ready():
	#Time Updates
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_update_stats")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

	#collectable updates
	collectable_tracker.connect("total_updated", self, "_update_stats")

	# First Update
	_update_stats()

func _update_stats():
	#Weird font formatting issues selved by adding spacing after zeros
	var time_formatted := ""
	if time_tracker.elapsed > 60:
		if time_tracker.elapsed % 60 < 10:
			time_formatted += "%d:0 %d" % [time_tracker.elapsed/60, time_tracker.elapsed%60]
		else :
			time_formatted += "%d:%02d" % [time_tracker.elapsed/60, time_tracker.elapsed%60]
	elif time_tracker.elapsed < 10:
		time_formatted += "0 :0 %d" % [time_tracker.elapsed]
	else:
		time_formatted += "0 :%02d" % [time_tracker.elapsed]

	#Update label
	text = "You've Collected: {amount} of {total}\n Level Time: {time}".format({
		'amount': collectable_tracker.collected_amount,
		'total': collectable_tracker.collectable_total,
		'time': time_formatted
		})
