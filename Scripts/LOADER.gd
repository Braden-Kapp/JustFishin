extends Node2D

@onready var manager = $FishManager
@onready var fish = $Fish
@onready var tracker = $CompletionTracker
# Called when the node enters the scene tree for the first time.
func _ready():
	fish.start_Fishing(manager.fish_library[0])
	tracker.start_tracking()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
