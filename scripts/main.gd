extends Node2D

@export var world_speed = 300

@onready var moving_environment = $Environment/Moving
@onready var distance_label = $HUD/UI/Distance
@onready var player = $Player

var platform = preload("res://scenes/platform.tscn")

var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var distance = 0
var prev_distance = 1.0

func _ready():
	rng.randomize()

func _process(delta):
	distance += 0.00003 * world_speed
	print(world_speed)
	
	if snapped(distance, 0) == prev_distance:
		prev_distance += 1
		if world_speed < 800:
			world_speed += 2

	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()

	# Update the UI labels
	distance_label.text = "%sm" % snapped(distance, 0)

func _spawn_next_platform():
	var platforms =[
		platform,
		platform,
		platform,
		platform,
		platform,
		platform,
	]
	var random_platform = platforms.pick_random()
	var new_platform = random_platform.instantiate()

	# Set position of new platform
	if last_platform_position == Vector2.ZERO:
		new_platform.position = Vector2(400, 0)
	else:
		var x = last_platform_position.x + rng.randi_range(450, 550) # Test values
		var y = clamp(last_platform_position.y + rng.randi_range(-150, 150), 200, 1000) # Test values
		new_platform.position = Vector2(x, y)

	# Add platform to moving environment
	moving_environment.add_child(new_platform)

	# Update last platform position and increase next spawn
	last_platform_position = new_platform.position
	next_spawn_time += world_speed

func _physics_process(delta):
	#Move plataforms left
	moving_environment.position.x -= world_speed * delta

func hit(value):
	player.is_hit()
	if world_speed / 2 > 250:
		world_speed = world_speed / 2
	else:
		world_speed = 250

func speed():
	return world_speed
