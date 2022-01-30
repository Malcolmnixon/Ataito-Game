extends Spatial

signal destroyed

func _on_RigidBody_picked_up(pickable):
	pickable.drop_and_free()
	emit_signal("destroyed")
