extends CharacterBody2D

signal player_died

@export var gravity = 5000
@export var jump_power = 1300
@export var camera2D: Camera2D
@export var speed = 800
@export var dash_speed = 4000
@export var dash_duration = 0.15

@onready var player = $"."
@onready var main = $"/root/Main"
@onready var sprite = $AnimatedSprite2D
@onready var camera = $"/root/Main/Camera2D"
@onready var collision = $CollisionShape2D
@onready var progress_bar = $ProgressBar

var min_speed = speed / 2.0
var active = true
var jumps_remaining = 1 # Change for double jump
var attacks_remaining = 3
var was_jumping = false
var was_hit = false
var is_attacking = false
var is_dashing = false
var can_dash = true
var timeout = 0
var god_mode = 0

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)

func _process(delta):
	god_mode -= delta
	timeout -= delta
	progress_bar.value = timeout
	if god_mode <=0 and is_dashing == true:
		is_dashing = false
		player.add_to_group('player')
	if timeout <=0:
		can_dash = true
		progress_bar.set_visible(false)

func _physics_process(delta):
	velocity.y += gravity * delta

	if active:
		# Reset after landing
		if is_on_floor() and was_jumping:
			was_jumping = false
			jumps_remaining = 1

		# Handle attacking
		if Input.is_action_just_pressed("attack") and attacks_remaining > 0:
			is_attacking = true
			attacks_remaining -= 1
			if attacks_remaining == 0:
				sprite.play("attack")
				attacks_remaining = 3
			elif attacks_remaining == 1:
				sprite.play("attack")
			elif attacks_remaining == 2:
				sprite.play("attack")

		# Handle jumping
		if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
			jumps_remaining -= 1
			was_jumping = true
			velocity.y = -jump_power
			if jumps_remaining == 0:
				if is_attacking == false:
					sprite.play("jump")
			#else:
				#sprite.play('double jump')
		if Input.is_action_just_released("jump"):
			velocity.y = +jump_power *delta

		# Handle walk
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction and not is_dashing:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	dash()
	move_and_slide()

func _on_animation_finished():
	if sprite.animation == "attack" or "attack" or "attack":
		is_attacking = false
	sprite.play('run')

func is_hit(value):
	if speed > min_speed:
		speed = speed - value * 60

func is_healed():
	if speed < 800:
		speed = 800

func die():
	player.frame_freeze(0.01, 0.4)
	sprite.stop()
	active = false
	collision.set_deferred("disabled", true)
	emit_signal("player_died")

func clear():
	sprite.stop()
	active = false

func frame_freeze(time_scale, duration):
	Engine.time_scale = time_scale
	await(get_tree().create_timer(duration * time_scale).timeout)
	Engine.time_scale = 1.0

func dash():
	if Input.is_action_just_pressed("dash") and can_dash:
			player.remove_from_group('player')
			god_mode = dash_duration
			can_dash = false
			is_dashing = true
			timeout = 1
			progress_bar.set_visible(true)
			velocity.x = dash_speed
