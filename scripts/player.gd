extends CharacterBody2D


@export var SPEED = 130.0
@export var JUMP_VELOCITY = -300.0

@export var sfx_jump : AudioStream
@export var sfx_walk : AudioStream
var walk_frames : Array = [1, 5, 9, 13]

func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $Sprite
@onready var coyote = $Coyote
@onready var buffer = $Buffer
var is_jumping = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and coyote.get_time_left() > 0:
		velocity.y = JUMP_VELOCITY
		load_sfx(sfx_jump)
		%sfx_player.play()
		is_jumping = true
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		load_sfx(sfx_jump)
		%sfx_player.play()
		is_jumping = true
	elif Input.is_action_just_pressed("jump"):
		buffer.start()

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if buffer.get_time_left() > 0:
			velocity.y = JUMP_VELOCITY
			load_sfx(sfx_jump)
			%sfx_player.play()
			is_jumping = true
			buffer.stop()
		elif direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	if not is_on_floor() and not is_jumping:
		coyote.start()
	if is_on_floor():
		is_jumping = false


func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.animation == "idle":	return
	if animated_sprite.animation == "jump":	return
	load_sfx(sfx_walk)
	if animated_sprite.frame in walk_frames : %sfx_player.play()
