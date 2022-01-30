extends Label

onready var board = get_parent().get_parent()

func _ready():
	board.connect("total_updated", self, "_update_total_display")
	_update_total_display(0, board.collectable_total)

func _update_total_display(amount, total):
	text = "To Get: {total}".format({'total': total})
