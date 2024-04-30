extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

var active = false

func _ready():
	hitbox.body_entered.connect(_on_body_entered)
	player.player_died.connect(_on_player_died)

func _process(delta):
	pass

func set_active(value):
	active = value
	if active:
		sprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("player"):
		if player.is_attacking:
			sprite.play("death")
			sprite.animation_finished.connect(_on_animation_finished)
		if not player.is_attacking:
			player.die()

func _on_player_died():
	set_active(false)
	sprite.stop()

func _on_animation_finished():
	queue_free()
