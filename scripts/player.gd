extends CharacterBody2D

@export var SPEED = 130.0
@export var JUMP_VELOCITY = -300.0
@export var sfx_jump : AudioStream
@export var sfx_walk : AudioStream
var walk_frames : Array = [1, 5, 9, 13]

@export var knockback_resistance: float = 1
var knockback: Vector2 = Vector2.ZERO
var knocked = false

func load_sfx(sfx_to_load):
	if %sfx_player.stream != sfx_to_load:
		%sfx_player.stop()
		%sfx_player.stream = sfx_to_load

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $Sprite
@onready var coyote = $Coyote
@onready var buffer = $Buffer
@onready var actionable_finder: Area2D = $ActionableFinder

func on_actionable():
	print("action!")
	signalbus.emit_signal("dialogue")

func _ready():
	signalbus.connect("knock",on_knock_received) 
	signalbus.connect("actionable", on_actionable)
	
var is_jumping = false

func _physics_process(delta):
	if knocked == false:
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
	elif knocked == true:
		velocity += knockback * delta
		velocity.y += gravity * delta
		move_and_slide()

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.animation == "idle":	return
	if animated_sprite.animation == "jump":	return
	load_sfx(sfx_walk)
	if animated_sprite.frame in walk_frames : %sfx_player.play()


func on_knock_received(knock_zone):
	print("collided")
	var collision_point = knock_zone.to_local(self.global_position)
	var direction_to_self = knock_zone.global_position - collision_point
	if animated_sprite.flip_h == false:
		knockback = Vector2(-direction_to_self.x * 10, -1300)
	else:
		knockback = Vector2(-direction_to_self.x * -10, -1300)
	animated_sprite.play("knocked")
	signalbus.emit_signal("_hit")
	knocked = true

	
func _on_sprite_animation_finished():
	if knocked == true:
		knocked = false
