extends Node2D

signal game_over

@export var world_speed = 800

@onready var moving = $Environment/Moving
@onready var distance_label = $HUD/UI/Distance
@onready var score_label = $HUD/UI/Score
@onready var start_label = $HUD/UI/Start
@onready var clear_label = $HUD/UI/Clear
@onready var player = $Player
@onready var ground = $Environment/Static/Ground

var platform = preload ("res://levels/level0/scenes/platform.tscn")
var enemy = preload ("res://levels/level0/scenes/enemy.tscn")
var destructible_enemy = preload ("res://levels/level0/scenes/destructible_enemy.tscn")
var moving_enemy = preload ("res://levels/level0/scenes/moving_enemy.tscn")

var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var distance = 0
var prev_distance = 1.0
var max_speed = world_speed
var min_speed = world_speed
var score = 37

var obstacle_types := [enemy, enemy, destructible_enemy]
var platforms: Array
var last_obstacle
var screen_size: Vector2
var moving_enemy_heights := [600, 750]

func _ready():
	screen_size = get_window().size
	rng.randomize()
	player.player_died.connect(_on_player_died)
	ground.body_entered.connect(_on_ground_body_entered)

func _process(delta):
	print(Engine.get_frames_per_second())
	if platforms.size() > 5:
		for plat in platforms:
			if plat.position.x > 3000:
				platforms.erase(plat)

	if not player.active:
		if Input.is_action_just_pressed("jump"):
			get_tree().reload_current_scene()
		return

	if snapped(distance, 0) > 800:
		clear_label.set_visible(true)
		player.clear()
		
	distance += 0.00005 * world_speed
	score -= 0.0003
	if score <= 30:
		player.die()

	if snapped(distance, 0) == prev_distance:
		prev_distance += 1
		if world_speed < max_speed:
			world_speed += 1

	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		_spawn_next_platform()
		_generate_obstacles()

	# Update the UI labels
	distance_label.text = str(Engine.get_frames_per_second()) + "fps"
	score_label.text = "temp: " + str(snapped(score, 0)) + " ºC"

func _spawn_next_platform():
	if platforms.size() <= 5:
		var new_platform = platform.instantiate()
		platforms.append(new_platform)
		
		# Set position of new platform
		new_platform.position = Vector2(last_platform_position.x + 3859, 538)

		# Add platform to moving environment
		moving.add_child(new_platform)

		# Update last platform position and increase next spawn
		last_platform_position = new_platform.position
		next_spawn_time += world_speed

func _generate_obstacles():
	var obstacle_type = obstacle_types.pick_random()
	var obs_number
	var obstacle = obstacle_type.instantiate()

	if randi_range(1, 10) < 6:
		obs_number = 2
	else:
		obs_number = 1
	if not last_obstacle:
		var x: int = screen_size.x + distance + randi_range( - 100, 50)
		var y: int = 786
		#Spawn Moving enemy
		if randi_range(1, 10) < 5:
			_add_obstacle(moving_enemy.instantiate(), x, moving_enemy_heights.pick_random())
		last_obstacle = obstacle
		_add_obstacle(obstacle, x, y)

		if obs_number == 2:
			obstacle = obstacle_type.instantiate()
			_add_obstacle(obstacle, x + 80, y)
	if last_obstacle:
		var x: int = last_obstacle.position.x + randi_range(550, 800)
		var y: int = 786
		last_obstacle = obstacle
		_add_obstacle(obstacle, x, y)
		if obs_number == 2:
			obstacle = obstacle_type.instantiate()
			_add_obstacle(obstacle, x + 80, y)

func _add_obstacle(obstacle, x, y):
	obstacle.position = Vector2i(x, y)
	moving.add_child(obstacle)

func _physics_process(delta):
	if not player.active:
		return

	#Move plataforms left
	moving.position.x -= world_speed * delta

func hit(value):
	player.is_hit()
	if world_speed / 2 > min_speed:
		world_speed = world_speed / 2
	else:
		world_speed = min_speed

func add_score(value):
	score = value

func speed():
	return world_speed

func _on_player_died():
	emit_signal("game_over")
	start_label.set_visible(true)

func _on_ground_body_entered(body):
	if body.is_in_group("player"):
		player.die()
