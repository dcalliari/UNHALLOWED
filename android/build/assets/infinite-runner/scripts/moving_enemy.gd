extends CharacterBody2D

@export var movement_speed = 300

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

var active = false

func _ready():
	hitbox.body_entered.connect(_on_body_entered)
	player.player_died.connect(_on_player_died)

func _physics_process(_delta):
	if not active:
		return

	velocity.x = -movement_speed
	move_and_slide()

func set_active(value):
	active = value
	if active:
		sprite.play("walk")

func _on_body_entered(body):
	if body.is_in_group("player") and not player.is_dashing:
		if player.is_attacking:
			player.die()
			#sprite.play("death")
			#sprite.animation_finished.connect(_on_animation_finished)

		if not player.is_attacking:
			player.die()

func _on_player_died():
	set_active(false)
	sprite.play("idle")

func _on_animation_finished():
	queue_free()
