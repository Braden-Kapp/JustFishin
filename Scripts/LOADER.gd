extends Node2D

@onready var manager = $FishManager
@onready var fish = $Fish
@onready var tracker = $CompletionTracker
@onready var player = $Player
@onready var FishAnimator = $FishAnimationPlayer

#Sprites To Have a toggle all visibilty function here
#Better Here than having to deal with all scripts individual
#------------------------------------------------------------
#Would've been better if I made it just assign things
#I wanted hidden in inspector but I was sleepy and it's done
@onready var playerSprite = $Player/PlayerSprite
@onready var fishSprite = $Fish/FishSprite
@onready var barSprite = $Art/FishingBar
@onready var lineSprite = $Art/FishingLine
@onready var CompletionBar = $CompletionTracker/ProgressBar

func _ready():
	if player.has_signal("cast"):
		player.cast.connect(on_cast)
	if tracker.has_signal("catch"):
		tracker.catch.connect(on_catch)
		
	hide_fishing()
	#fish.start_Fishing(manager.fish_library[0])
	#tracker.start_tracking() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_fishing():
	playerSprite.visible = false
	fishSprite.visible = false
	barSprite.visible = false
	lineSprite.visible = false
	CompletionBar.visible = false

func show_fishing():
	playerSprite.visible = true
	fishSprite.visible = true
	barSprite.visible = true
	CompletionBar.visible = true

func show_casting():
	lineSprite.visible = true

func on_cast():
	show_casting()
	# Play fish animation and wait for finish
	FishAnimator.play("FishBiteLower")
	await FishAnimator.animation_finished
	#Start Gameplay
	show_fishing()
	player.fishing = true
	fish.start_Fishing(manager.fish_library[0])
	tracker.start_tracking() 

func on_catch():
	hide_fishing()
	fish.stop_Fishing()
	# Play catch animation and wait for finish
	FishAnimator.play("FishCaught")
	await FishAnimator.animation_finished
	player.fishing = false
