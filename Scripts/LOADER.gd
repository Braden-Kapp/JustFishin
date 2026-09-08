extends Node2D

@onready var manager = $FishManager
@onready var fish = $Fish
@onready var tracker = $CompletionTracker
@onready var player = $Player
@onready var FishAnimator = $FishAnimationPlayer
@onready var UIAnimator = $UIAnimationPlayer

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

@onready var UINotification = $Art/Notification
var missed: bool = false
var isCasting: bool = false

func _ready():
	if player.has_signal("cast"):
		player.cast.connect(on_cast)
	if tracker.has_signal("catch"):
		tracker.catch.connect(on_catch)
		
	hide_fishing()
	#fish.start_Fishing(manager.fish_library[0])
	#tracker.start_tracking() 

# Process handles the button check cleanly each frame without blocking the thread
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fishButtons") and UIAnimator.is_playing() and UIAnimator.current_animation == "CatchUI":
		UIAnimator.stop(false) # Stopping with false prevents trigger bugs
		UINotification.visible = false
		begin_fishin()

func hide_fishing():
	playerSprite.visible = false
	fishSprite.visible = false
	barSprite.visible = false
	lineSprite.visible = false
	CompletionBar.visible = false
	UINotification.visible = false

func show_fishing():
	playerSprite.visible = true
	fishSprite.visible = true
	barSprite.visible = true
	CompletionBar.visible = true

func show_casting():
	lineSprite.visible = true

func on_cast():
	if isCasting or player.fishing:
		return
	isCasting = true
	missed = false
	show_casting()
	# Play fish animation and wait for finish
	FishAnimator.play("FishBiteLower")
	await FishAnimator.animation_finished
	UINotification.visible = true
	UIAnimator.play("CatchUI")

func begin_fishin():
	#Start Gameplay
	isCasting = false
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

func missed_catch():
	isCasting = false
	missed = true
	player.fishing = false
	hide_fishing()
	fish.stop_Fishing()
	FishAnimator.play("RESET")

func _on_ui_animation_player_animation_finished(anim_name: StringName) -> void:
	# Only if the animation finished without catch
	if not player.fishing:
		missed = true
		UINotification.visible = false
		missed_catch()
		
