extends Area2D

@export var value = 37

@onready var game = $"/root/Main"
@onready var sprite = $AnimatedSprite2D

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		game.add_temp(value)
		sprite.play("collected")
		sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	queue_free()
