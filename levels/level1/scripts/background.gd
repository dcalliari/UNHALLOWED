extends ParallaxBackground

@onready var main = $"/root/Main"
@onready var player = $"/root/Main/Player"

func _ready():
	pass

func _physics_process(delta):
	if not player.active:
		return
	var speed = main.speed() / 10
	scroll_base_offset -= Vector2(speed, 0) * delta
