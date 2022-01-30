extends Node

var time_start = 0
var elapsed := 0 setget ,get_elapsed_time
export var autostart := true
export var running := false
var started := false

func _ready():
	running = autostart
	if running:
		restart_time()

func restart_time():
	started = false
	start_time()

func start_time():
	if started:
		return
	time_start = OS.get_unix_time()
	elapsed = 0
	running = true
	started = true

func get_elapsed_time():
	if running:
		var time_now = OS.get_unix_time()
		elapsed = time_now - time_start
	return elapsed

func stop_time():
	get_elapsed_time()
	running = false
	return elapsed
