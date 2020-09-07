extends KinematicBody2D

var alive = true

var lastSafePosition = Vector2(0, 0)

#Variables that need to be set to false at the start so the player has progression 
export var canDash = false;
export var maxJumps = 1;
export var canFloat = false;
export var canWallJump = false;

export var maxSpeed = Vector2(750.0, 800.0)
export var HORIZONTAL_DAMPING = 0.4
export var HORIZONTAL_DAMPING_WHEN_STOPPING = 0.8
export var maxGravity = 800.0
export var jumpSpeed = -170
export var dashSpeed = 600.0

var velocity = Vector2(0, 0)
var jumps = maxJumps
var gravity = maxGravity

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

var SnapVector = Vector2(0, 6)
export var MAX_SLOPE = 45.0 * PI / 180.0

export var WALL_REMEMBER_TIME = 0.1
var wallRememberTimer = 0.0
var wallDir = 1


func _ready():
	Global.player = self
	$Sprite.modulate = Color(1, 1, 1)
	startColor = $Sprite.modulate
	lastSafePosition = position

func _physics_process(delta):
	if !alive:
		position.y -= 10 * delta
		$ChuteSprite.visible = false
		return
	
	var newMovement = Vector2(0, 0)
	
	var desiredColor = startColor
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (direction != 0):
		newMovement.x = maxSpeed.x * direction * delta
		
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
		desiredColor = Color(1, 1, 1)
		SnapVector.y = 6.0
		gravity = maxGravity
		$ChuteSprite.visible = false
	else:
		# Don't start "falling" until a short period after leaving the ground
		# This means we won't eat the jump until they have fallen a certain duration
		if !falling and fallTimer <= 0.0:
			fallTimer = FALL_TIME
			falling = false
		else:
			if Input.is_action_pressed("move_jump") and velocity.y > 0.0 and canFloat: # Slow fall
				newMovement.y += gravity * 0.1 * delta 
				if velocity.y > (maxSpeed.y * 0.1):
					velocity.y = maxSpeed.y * 0.1
				if falling:
					$Sprite.frame = 4
					desiredColor = Color(1, 0.714844, 0.868561)
				$ChuteSprite.visible = true
			else: # Normal fall
				$ChuteSprite.visible = false
				newMovement.y += gravity * delta
				if falling:
					desiredColor = Color(0.935638, 0.777344, 1)
					$Sprite.frame = 3
			if !falling:
				fallTimer -= delta
				if fallTimer <= 0.0: 
					falling = true
					if jumps == maxJumps:
						jumps -= 1
	
	if is_on_wall():
		wallRememberTimer = WALL_REMEMBER_TIME
		wallDir = dashDirection
	else:
		wallRememberTimer -= delta
	
	if (Input.is_action_just_pressed("move_jump") && jumps > 0 && (wallRememberTimer <= 0.0 or is_on_floor())):
		velocity.y = jumpSpeed
		falling = true
		fallTimer = 0.0
		if jumps != maxJumps:
			$Particles2D.emitting = true
		jumps -= 1
		SnapVector.y = 0
	elif (canWallJump && Input.is_action_just_pressed("move_jump") && wallRememberTimer > 0.0  && !is_on_floor()):
		velocity.y = jumpSpeed*1.2
		falling = true
		fallTimer = 0.0
		SnapVector.y = 0
		velocity.x = maxSpeed.x * -wallDir *.35
		$Particles2D.emitting = true
	else:
		$Particles2D.emitting = false
	
	if dashCooldownTimer <= 0.0 and Input.is_action_just_pressed("move_dash") and canDash:
		if !dashing:
			dashTimer = DASH_TIME
			dashing = true
	if dashing:
		dashTimer -= delta
		SnapVector.y = 0
		velocity.x = dashSpeed * dashDirection
		velocity.y = 0.0
		desiredColor = Color(0.025009, 0.582031, 0.5037);
		if dashTimer <= 0.0:
			dashCooldownTimer = DASH_COOLDOWN
			dashing = false
		$Particles2D.emitting = true
	elif dashCooldownTimer > 0.0:
		dashCooldownTimer -= delta
		desiredColor.b = lerp(1.0, startColor.b, (DASH_COOLDOWN - dashCooldownTimer) / DASH_COOLDOWN)
	
#	desiredColor.r = 1.0 - (float(jumps) / maxJumps)
	$Sprite.modulate = lerp($Sprite.modulate, desiredColor, 4.0 * delta)
	
	velocity += newMovement
	
	velocity.x = clamp(velocity.x, -maxSpeed.x, maxSpeed.x)
	velocity.y = clamp(velocity.y, -maxSpeed.y * 100.0, maxSpeed.y)
	
	velocity = move_and_slide_with_snap(velocity, SnapVector, Vector2(0, -1), true, 4, 0.8)
	
	if direction:
		velocity.x *= pow(1 - HORIZONTAL_DAMPING, delta * 10)
	else: # Stopping
		velocity.x *= pow(1 - HORIZONTAL_DAMPING_WHEN_STOPPING, delta * 10)
	
	if (Input.is_action_just_pressed("move_down")):
		lastSafePosition = position

func die():
	alive = false
	$AnimationPlayer.play("Death")
	$CollisionShape2D.disabled = true


func respawn():
	alive = true
	$AnimationPlayer.play("Idle")
	$CollisionShape2D.disabled = false
	position = lastSafePosition
