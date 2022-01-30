extends Node
class_name CollectableTracker

var collectable_total := 0 setget , _get_total
var collected_amount := 0 setget , _get_collected
var collected_light := 0
var collected_dark := 0

signal total_updated(amount, total)

func _ready():
	var collectables = get_tree().get_nodes_in_group("collectable")
	collectable_total = collectables.size()
	for c in collectables:
		c.connect("collected", self, "on_Collectable_collected")

func on_Collectable_collected(type, _node):
	if type == SpiritOrb.Alignment.Light:
		#print("light collected")
		collected_light += 1
	else:
		#print("dark collected")
		collected_dark += 1
	var collected := _get_collected()
	print("total of {num} collected of {total}".format({'num': collected, 'total': collectable_total}))
	emit_signal("total_updated", collected, collectable_total)

func _get_collected() -> int:
	return collected_light + collected_dark

func _get_total() -> int:
	if collectable_total == 0:
		collectable_total = get_tree().get_nodes_in_group("collectable").size()
	return collectable_total
