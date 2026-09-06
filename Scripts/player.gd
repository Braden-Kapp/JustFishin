extends RigidBody2D
signal cast

@export var up = -1500.0 
var fishing = false

func _physics_process(_delta: float) -> void:
	if !fishing && Input.is_action_pressed("fishButtons"):
		emit_signal("cast")
	elif fishing  && Input.is_action_pressed("fishButtons"):
		apply_central_force(Vector2(0, up))
	
