extends RigidBody2D

# Adjust this force to combat your project's gravity settings
const UP = -2000.0 

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("fishButtons"):
		apply_central_force(Vector2(0, UP))
