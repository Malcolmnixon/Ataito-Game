extends CollectableTracker
class_name AtaitoPlayer

onready var _ape_player = preload("res://ataito/player/ape/ApePlayer.tscn")
onready var _bird_player = preload("res://ataito/player/bird/BirdPlayer.tscn")

onready var _player: AnimalController = $Player
onready var _player_body: PlayerBody = $Player/PlayerBody

onready var _set_animal_cooldown = $AnimalSwitchCooldown
var _cooling_down := false

enum Animal {
	Ape = 1,
	Bird = 2
}

export var current_animal := Animal.Ape


func _ready():
	if _player:
		_player.connect("toggle_animal", self, "toggle_animal")
	else:
		set_animal(current_animal)
	_set_animal_cooldown.connect("timeout", self, "_cooldown_ended")

func toggle_animal():
	set_animal( Animal.Bird if current_animal == Animal.Ape else Animal.Ape )

func set_animal_ape():
	set_animal(Animal.Ape)

func set_animal_bird():
	set_animal(Animal.Bird)

func set_animal(animal):
	if _cooling_down:
		return

	var player_template = _ape_player if animal == Animal.Ape else _bird_player

	# Save the current player transform and velocity
	var player_transform = _player.global_transform
	var player_velocity = _player_body.velocity

	#disconnect signals
	_player.disconnect("toggle_animal", self, "toggle_animal")

	yield(get_tree(), "physics_frame")

	# Destroy the old player
	remove_child(_player)
	_player.free()

	# Load the new player
	_player = player_template.instance()
	_player.set_name("Player")
	_player_body = _player.get_node("PlayerBody")

	# Place the player
	add_child(_player)
	_player.global_transform = player_transform
	_player_body.velocity = player_velocity

	#connect signals
	_player.connect("toggle_animal", self, "toggle_animal")

	# Play the animal sound
	_player.play_animal_sound()

	current_animal = animal
	_cooling_down = true
	_set_animal_cooldown.start()

func _cooldown_ended():
	_cooling_down = false
