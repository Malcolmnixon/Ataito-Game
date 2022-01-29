extends Spatial
class_name CollectableTracker

var collected_total := 0 setget , _get_total
var collected_light := 0
var collected_dark := 0

func _ready():
	var collectables = get_tree().get_nodes_in_group("collectable")
	for c in collectables:
		c.connect("collected", self, "on_Collectable_collected")


func on_Collectable_collected(type, _node):
	if type == Collectable.Alignment.Light:
		print("light collected")
		collected_light += 1
	else:
		print("dark collected")
		collected_dark += 1
	print("total of {num} collected".format({'num': _get_total()}))

func _get_total() -> int:
	return collected_light + collected_dark
