extends KinematicBody2D
export var maxSpeed = Vector2(300, 4000);
var velocity: = Vector2(0, 0);
var jumps: = 2;
export var gravity: = 300.0;


func _physics_process(delta:float) -> void:
	var direction = Input.get_action_strength("move_right")- Input.get_action_strength("move_left");
	velocity.x = maxSpeed.x * direction;
	velocity.y += gravity * delta;
	if (velocity.y > maxSpeed.y):
		velocity.y = maxSpeed.y;
	if (Input.get_action_strength("move_jump") > 0 && jumps > 0):
		velocity.y -= 100;
		--jumps
	if (is_on_floor()):
		jumps = 2
	velocity = move_and_slide(velocity);

