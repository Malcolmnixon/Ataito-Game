extends FirstPersonControllerVR
class_name AnimalController

signal toggle_animal

func _toggle_animal():
	emit_signal("toggle_animal")
