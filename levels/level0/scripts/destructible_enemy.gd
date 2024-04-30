extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

func _ready():
	hitbox.body_entered.connect(_on_body_entered)

func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		if player.is_attacking:
			sprite.play("death")
			sprite.animation_finished.connect(_on_animation_finished)
		if not player.is_attacking:
			player.die()

func _on_animation_finished():
	queue_free()
