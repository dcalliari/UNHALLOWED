extends CharacterBody2D

signal player_died

@export var gravity = 3000
@export var jump_power = 1000
@export var camera2D: Camera2D
@export var speed = 800

@onready var player = $"."
@onready var main = $"/root/Main"
@onready var sprite = $AnimatedSprite2D
@onready var camera = $"/root/Main/Camera2D"
@onready var collision = $CollisionShape2D

var min_speed = 200
var active = true
var jumps_remaining = 1 # Change for double jump
var attacks_remaining = 3
var was_jumping = false
var was_hit = false
var is_attacking = false
var is_god = false

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)

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
		if Input.is_action_just_released("jump") and velocity.y < - jump_power / 2.0:
			velocity.y = -jump_power / 2.0

		# Handle walk
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
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
	sprite.stop()
	active = false
	collision.set_deferred("disabled", true)
	emit_signal("player_died")

func clear():
	sprite.stop()
	active = false
