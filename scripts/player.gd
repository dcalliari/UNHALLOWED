extends CharacterBody2D

signal player_died

@export var gravity = 3200
@export var jump_power = 600
@export var camera2D: Camera2D
@export var speed = 600

@onready var sprite = $AnimatedSprite2D
@onready var camera = $"/root/Main/Camera2D"
@onready var collision = $CollisionShape2D
@onready var collisionRolling = $CollisionShapeRolling
@onready var collisionAttacking = $CollisionShapeAttacking


var active = true
var jumps_remaining = 1 # Change for double jump
var attacks_remaining = 3
var was_jumping = false
var was_hit = false

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity * delta

	if active:
		# Update camera position
		# camera.position = position + Vector2(480, 0)

		# Reset after landing
		if is_on_floor() and was_jumping:
			if was_jumping:
				was_jumping = false
				jumps_remaining = 1
				sprite.play("run")

		# Handle hit
		if was_hit and not sprite.is_playing():
			was_hit = false
			sprite.play("run")
			collision.set_disabled(false)
			collisionRolling.set_disabled(true)
		
		# Handle attacking
		if Input.is_action_just_pressed("attack") and attacks_remaining > 0:
			attacks_remaining -= 1
			if attacks_remaining == 0:
				sprite.play("attack3")
				attacks_remaining = 3
			elif attacks_remaining == 1:
				sprite.play("attack2")
			elif attacks_remaining == 2:
				sprite.play("attack")
		
		# Handle jumping
		if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
			jumps_remaining -= 1
			was_jumping = true
			velocity.y = -jump_power
			if jumps_remaining == 0:
				sprite.play("jump")
			#else:
				#sprite.play('double jump')
		if Input.is_action_just_released("jump") and velocity.y < -jump_power/2.0:
			velocity.y = -jump_power/2.0

		# Handle walk
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()


func is_hit():
	if not was_jumping:
		sprite.play("roll")
		collision.set_disabled(true)
		collisionRolling.set_disabled(false)
		was_hit = true

func die():
	sprite.stop()
	active = false
	collision.set_deferred("disabled", true)
	collisionRolling.set_deferred("disabled", true)
	emit_signal("player_died")
