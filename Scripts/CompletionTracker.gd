extends Node2D
signal catch

var startTracking: bool = false
var current: int
var gain: bool

@onready var sprite = $Sprite2D

func start_tracking():
	startTracking = true
	current = 20
	sprite.position.x = 0 #TESTINGONLY


func _process(delta: float) -> void:
	if startTracking:
			if gain:
				current += 1
			else:
				current -= 1
				
			if current >= 200:
				startTracking = false #Stops repeats
				sprite.position.x = 530 #TESTINGONLY
				emit_signal("catch")


func _on_area_2d_player_area_entered(area: Area2D) -> void:
	gain = true
func _on_area_2d_area_exited(area: Area2D) -> void:
	gain = false
