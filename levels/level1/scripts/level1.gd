extends Node2D

signal game_over

@export var world_speed = 800

@onready var moving = $Environment/Moving
@onready var distance_label = $HUD/UI/Distance
@onready var temp_label = $HUD/UI/Temp
@onready var start_label = $HUD/UI/Start
@onready var clear_label = $HUD/UI/Clear
@onready var bar = $HUD/UI/Bar
@onready var player = $Player
@onready var ground = $Environment/Static/Ground

var platform = preload ("res://levels/level1/scenes/platform.tscn")
var enemy = preload ("res://levels/level1/scenes/enemy.tscn")
var destructible_enemy = preload ("res://levels/level1/scenes/destructible_enemy.tscn")

var rng = RandomNumberGenerator.new()
var last_platform_position = Vector2.ZERO
var next_spawn_time = 0
var distance = 0
var prev_distance = 1.0
var max_speed = world_speed
var min_speed = world_speed
var start_temp = 37
var min_temp = 30
var temp = 37
var end = 800

var level1
var first_time

var obstacle_types := [enemy, enemy, destructible_enemy]
var platforms: Array
var last_obstacle
var screen_size: Vector2

func _ready():
	first_time = true
	screen_size = get_window().size
	rng.randomize()
	player.player_died.connect(_on_player_died)
	ground.body_entered.connect(_on_ground_body_entered)

func _process(delta):

	if platforms.size() > 5:
		for plat in platforms:
			if plat.position.x > 3000:
				platforms.erase(plat)

	if snapped(distance, 0) > end:
		player.remove_from_group("player")
		level1 = true
		clear_label.set_visible(true)
		player.clear()

	if player.active:
		distance += 0.03 * world_speed * delta
		bar.value = distance
		temp -= 0.5 * delta

	if temp < start_temp:
		var value = start_temp - temp
		player.is_hit(value)
		start_temp = temp

	if snapped(distance, 0) == prev_distance:
		prev_distance += 1
		if world_speed < max_speed:
			world_speed += 1

	# Spawn a new platform
	if Time.get_ticks_msec() > next_spawn_time:
		if distance < end * 0.8:
			_spawn_next_platform()
			_generate_obstacles()

	# Update the UI labels
	# distance_label.text = str(snapped(distance, 0)) + "m"
	temp_label.text = "temp: " + str(snapped(temp, 0)) + " ºC"

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

func add_temp(value):
	temp = value
	start_temp = temp
	player.is_healed()

func speed():
	return world_speed

func _on_player_died():
	emit_signal("game_over")
	start_label.set_visible(true)

func _on_ground_body_entered(body):
	if body.is_in_group("player"):
		player.die()

func retry():
	get_tree().reload_current_scene()
