extends Node2D

@onready var manager = $FishManager
@onready var fish = $Fish
@onready var tracker = $CompletionTracker
@onready var player = $Player

#Sprites To Have a toggle all visibilty function here
#Better Here than having to deal with all scripts
@onready var playerSprite = $Player/PlayerSprite
@onready var fishSprite = $Fish/FishSprite
@onready var barSprite = $Art/FishingBar
@onready var CompletionSprite = $CompletionTracker/Sprite2D

func _ready():
	if player.has_signal("cast"):
		player.cast.connect(on_cast)
	if tracker.has_signal("catch"):
		tracker.catch.connect(on_catch)
	#fish.start_Fishing(manager.fish_library[0])
	#tracker.start_tracking() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_fishing():
	playerSprite.visible = false
	fishSprite.visible = false
	barSprite.visible = false
	CompletionSprite.visible = false

func show_fishing():
	playerSprite.visible = true
	fishSprite.visible = true
	barSprite.visible = true
	CompletionSprite.visible = true

func on_cast():
	show_fishing()
	player.fishing = true
	fish.start_Fishing(manager.fish_library[1])
	tracker.start_tracking() 

func on_catch():
	hide_fishing()
	fish.stop_Fishing()
	#await fish being thrown animation
	player.fishing = false
