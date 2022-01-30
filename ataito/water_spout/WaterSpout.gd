extends Spatial

func _on_GrabDestroyBoulder_destroyed():
	$Spout.emitting = true
	$WindArea/CollisionShape.disabled = false
	pass # Replace with function body.
