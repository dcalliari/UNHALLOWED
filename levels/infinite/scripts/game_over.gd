extends Area2D

@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.die()
