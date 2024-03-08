extends CharacterBody2D

@onready var animPlayer = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var collisionRolling = $CollisionShapeRolling

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animPlayer.play('jump')
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("roll") and is_on_floor():
		animPlayer.play('roll')
		collision.set_disabled(true)
		collisionRolling.set_disabled(false)
		
	if not animPlayer.is_playing():
		animPlayer.play("running")
		collision.set_disabled(false)
		collisionRolling.set_disabled(true)

	move_and_slide()
