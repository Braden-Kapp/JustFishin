class_name FishManager
extends Node

# Holds the library of available fish definitions
@export var fish_library: Array[FishData] = []

# Get a random fish from your library
func get_random_fish() -> FishData:
	if fish_library.is_empty():
		return null
	return fish_library.pick_random()

# I could put fish in the library with code like this
#It's that or inspector and I don't really trust the inspector
func _ready() -> void:
	# Add fish using helper
	#Y vals should be between -254 and 75
	_create_fish("Bass", "res://Art/icon.svg", 35, 1.5, [-200.0, 25.5, 30.0, -120, -40, -60, -25])
	_create_fish("Trout", "res://Art/icon.svg", 5.0, 0.8, [15.0, 30.0, 50.0])
	_create_fish("Catfish", "res://Art/icon.svg", 1.2, 4.0, [80.0, 90.0, 100.0])
	


func _create_fish(fish_name: String, img_path: String, speed: float, wait: float, y_coords: Array[float]) -> void:
	var fish = FishData.new()
	fish.name = fish_name
	fish.image = load(img_path)
	fish.speed = speed
	fish.wait_time = wait
	fish.y_coordinates = y_coords
	
	fish_library.append(fish)
