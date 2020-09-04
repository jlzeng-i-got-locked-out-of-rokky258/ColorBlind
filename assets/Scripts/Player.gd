extends KinematicBody2D
export var maxSpeed = Vector2(300, 4000);
var velocity: = Vector2(0, 0);
export var gravity: = 300.0;
func _physics_process(delta:float) -> void:
	var direction = Input.get_action_strength("move_right")- Input.get_action_strength("move_left");
	velocity.x = maxSpeed.x * direction;
	velocity.y += gravity * delta;
	if (velocity.y > maxSpeed.y):
		velocity.y = 0;

	velocity = move_and_slide(velocity);

