extends KinematicBody2D

export var maxSpeed = Vector2(225, 4000)
export var jumpSpeed = -170
var velocity = Vector2(0, 0)
var jumps = 2
export var gravity = 800.0


func _physics_process(delta:float) -> void:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (direction != 0):
		velocity.x = maxSpeed.x * direction
		if (direction > 0):
			get_node( "Sprite" ).set_flip_h( false )
		if (direction < 0):
			get_node( "Sprite" ).set_flip_h( true )
	velocity.y += gravity * delta
	if (velocity.y > maxSpeed.y):
		velocity.y = maxSpeed.y
	if (is_on_floor()):
		jumps = 2
	if (Input.is_action_just_pressed("move_jump") && jumps > 0):
		velocity.y = jumpSpeed
		jumps -= 1
	if (Input.is_action_just_pressed("move_dash")):
		if(direction > 0):
			velocity.x = 800
		if(direction < 0):
			velocity.x = -800
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity.x *= 0.65
