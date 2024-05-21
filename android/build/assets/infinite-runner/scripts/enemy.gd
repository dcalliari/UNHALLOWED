extends CharacterBody2D

@onready var main = $"/root/Main"
@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/Main/Player"

var active = false
var idle = "level0"

func _ready():
	hitbox.body_entered.connect(_on_body_entered)
	player.player_died.connect(_on_player_died)

func _process(_delta):
	_level_change()

func set_active(value):
	active = value
	if active:
		sprite.play(idle)


func _on_body_entered(body):
	if body.is_in_group("player") and not player.is_dashing:
		player.die()

func _on_player_died():
	set_active(false)
	sprite.stop()

func _on_animation_finished():
	queue_free()

func _level_change():
	if main.level == 0:
		if randi_range(1, 10) > 5:
			idle = "level0"
		else:
			idle = "level00"
	if main.level == 1:
		idle = "level1"
	if main.level == 2:
		idle = "level2"
