extends Node2D
signal catch

var startTracking: bool = false
var current: int
var gain: bool

@onready var progress_bar = $ProgressBar

func start_tracking():
	startTracking = true
	current = 20
	progress_bar.min_value = 0
	progress_bar.max_value = 200
	progress_bar.value = current

func _process(delta: float) -> void:
	if startTracking:
		if gain:
			current += 1
		else:
			current -= 1
			
		# Clamp current value to stay within 0-200 bounds
		current = clamp(current, 0, 200)
		progress_bar.value = current
			
		if current >= 200:
			startTracking = false #Stops repeats
			emit_signal("catch")

func _on_area_2d_player_area_entered(area: Area2D) -> void:
	gain = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	gain = false
