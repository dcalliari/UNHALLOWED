extends Area2D

@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

func _ready():
	hitbox.body_entered.connect(_on_body_entered)

func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.die()

func _on_animation_finished():
	queue_free()
