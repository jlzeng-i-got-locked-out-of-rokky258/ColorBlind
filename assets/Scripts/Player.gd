extends KinematicBody2D
export var maxSpeed = Vector2(300, 1000);
var velocity: = Vector2(0, 0);
export var gravity: = 300.0;
func _physics_process(delta:float) -> void:
	velocity.y += gravity * delta;
	if (velocity.y > maxSpeed.y):
		velocity.y = 0;
	velocity = move_and_slide(velocity);
	
