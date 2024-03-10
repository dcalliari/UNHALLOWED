extends ParallaxBackground

@onready var main = $"/root/Main"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var speed = main.speed()/10
	scroll_base_offset -= Vector2(speed, 0) * delta
