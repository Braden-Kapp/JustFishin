extends Node2D

@export var curFish: FishData
@export var speed: float = 200.0
var curFishPositions: Array[float] = []

# Load Fish Node
@onready var startX: float
@onready var fishSprite: Sprite2D = $FishSprite

var targetPosition: Vector2 = Vector2.ZERO
var posSize: int = 0
var current: int = 0
var waitTime: float = 0.0
var isMoving: bool = false

func stop_Fishing():
	isMoving = false
	fishSprite.visible = false
	curFishPositions = []
	targetPosition.y = 0
	posSize = 0

func start_Fishing(data: FishData):
	if not data:
		return
	# Receive Fish
	curFish = data
	# Set Up
	speed = curFish.speed * 10
	waitTime = curFish.wait_time
	curFishPositions = curFish.y_coordinates
	posSize = curFishPositions.size()
	current = 0
	startX = position.x 
	
	#In case I wanna change image per fish
	#if fishSprite and curFish.image:
	#	fishSprite.texture = curFish.image
	# ENSURE coordinates exist
	if posSize > 0:
		targetPosition = Vector2(startX, curFishPositions[current])
		isMoving = true
	else:
		print_debug("Warning: Fish ", curFish.name, " has no y_coordinates set!")

func _process(delta: float) -> void:
	if not isMoving or posSize == 0:
		return

	# Move toward target
	if global_position != targetPosition:
		global_position = global_position.move_toward(targetPosition, speed * delta)
	else:
		 #pause and pick
		_advance_to_next_position()

func _advance_to_next_position() -> void:
	isMoving = false
	
	# Wait before moving
	if waitTime > 0:
		await get_tree().create_timer(waitTime * 0.4).timeout
	# ERROR CHECK: posSize could,ve been set to 0 during await!
	if posSize == 0:
		return
	# Increment index and wrap
	current = (current + 1) % posSize
	targetPosition.y = curFishPositions[current]
	
	isMoving = true
