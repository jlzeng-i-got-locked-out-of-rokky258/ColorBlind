extends KinematicBody2D

export var maxSpeed = Vector2(2250.0, 800.0)
export var gravity = 800.0
export var maxJumps = 2
export var jumpSpeed = -170
export var dashSpeed = 600.0

var velocity = Vector2(0, 0)
var jumps = maxJumps

export var WALK_FRAME_TIME = 0.2
var frameTimer = 0.0

export var FALL_TIME = 0.15
var fallTimer = 0.0
var falling = false

var startColor

export var DASH_COOLDOWN = 1.5
export var DASH_TIME = 0.1
var dashTimer = 0.0
var dashing = false
var dashDirection = 0
var dashCooldownTimer = 0.0

func _ready():
	Global.player = self
	$Sprite.modulate = Color(0.0, 0.0, 0.0, 1.0)
	startColor = $Sprite.modulate


func _physics_process(delta):
	if (velocity.y > maxSpeed.y):
		velocity.y = maxSpeed.y
	
	var desiredColor = startColor
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (direction != 0):
		velocity.x += maxSpeed.x * direction * delta
		velocity.x = clamp(velocity.x, -maxSpeed.x, maxSpeed.x)
		
		if !dashing:
			dashDirection = sign(direction)
		
		if frameTimer <= 0.0:
			frameTimer = WALK_FRAME_TIME
		else:
			frameTimer -= delta
		if (direction > 0):
			$Sprite.flip_h = false
		elif (direction < 0):
			$Sprite.flip_h = true
		if frameTimer < 0.0:
			if $Sprite.frame == 0:
				$Sprite.frame = 1
			else:
				$Sprite.frame = 0
			frameTimer = WALK_FRAME_TIME
	else:
		$Sprite.frame = 0
		frameTimer = 0.0
	
	if (is_on_floor()):
		jumps = maxJumps
		velocity.y = 0.0
		fallTimer = 0.0
		falling = false
		desiredColor.g = 0.0
	else:
		# Don't start "falling" until a short period after leaving the ground
		# This means we won't eat the jump until they have fallen a certain duration
		if !falling and fallTimer <= 0.0:
			fallTimer = FALL_TIME
			falling = false
		else:
			if Input.is_action_pressed("move_jump") and velocity.y > 0.0: # Slow fall
				velocity.y += gravity * 0.25 * delta 
				if falling:
					$Sprite.frame = 4
					desiredColor.g = 1.0
			else: # Normal fall
				velocity.y += gravity * delta
				if falling:
					desiredColor.g = 0.0
					$Sprite.frame = 3
			if !falling:
				fallTimer -= delta
				if fallTimer <= 0.0: 
					falling = true
					if jumps == maxJumps:
						jumps -= 1
	
	if (Input.is_action_just_pressed("move_jump") && jumps > 0):
		velocity.y = jumpSpeed
		falling = true
		fallTimer = 0.0
		jumps -= 1
	if dashCooldownTimer <= 0.0 and Input.is_action_just_pressed("move_dash"):
		if !dashing:
			dashTimer = DASH_TIME
			dashing = true
	if dashing:
		dashTimer -= delta
		velocity.x = dashSpeed * dashDirection
		velocity.y = 0.0
		desiredColor.b = 1.0
		if dashTimer <= 0.0:
			dashCooldownTimer = DASH_COOLDOWN
			dashing = false
	elif dashCooldownTimer > 0.0:
		dashCooldownTimer -= delta
		desiredColor.b = lerp(1.0, startColor.b, (DASH_COOLDOWN - dashCooldownTimer) / DASH_COOLDOWN)
	
	desiredColor.r = 1.0 - (float(jumps) / maxJumps)
	$Sprite.modulate = lerp($Sprite.modulate, desiredColor, 4.0 * delta)
	
	velocity.x *= 0.85
	velocity = move_and_slide(velocity, Vector2(0, -1))
