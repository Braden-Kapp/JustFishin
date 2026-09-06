extends Node2D


var startTracking: bool = false
var current: int
var gain: bool
var caught: bool

@onready var sprite = $Sprite2D

func start_tracking():
	startTracking = true
	current = 20
	caught = false


func _process(delta: float) -> void:
	if startTracking:
			if gain:
				current += 2
			else:
				current -= 1
				
			if current >= 80:
				caught = true
				sprite.position.x = 530


func _on_area_2d_player_area_entered(area: Area2D) -> void:
	gain = true
func _on_area_2d_area_exited(area: Area2D) -> void:
	gain = false
