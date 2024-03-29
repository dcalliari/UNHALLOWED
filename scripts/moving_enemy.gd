extends CharacterBody2D

@export var movement_speed = 300

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if not active:
		return

	velocity.x = -movement_speed
	move_and_slide()

func set_active(value):
	active = value
	if active:
		sprite.play("walk")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.die()
