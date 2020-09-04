extends KinematicBody2D

export var maxSpeed = Vector2(300, 4000)
export var jumpSpeed = -200
var velocity = Vector2(0, 0)
var jumps = 2
export var gravity = 300.0


func _physics_process(delta:float) -> void:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (direction != 0):
		velocity.x = maxSpeed.x * direction
	velocity.y += gravity * delta
	if (velocity.y > maxSpeed.y):
		velocity.y = maxSpeed.y
	if (is_on_floor()):
		jumps = 2
	if (Input.is_action_just_pressed("move_jump") && jumps > 0):
		velocity.y = jumpSpeed
		jumps -= 1
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity.x *= 0.65
