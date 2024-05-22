extends Node

@onready var music = $"/root/Music/AudioStreamPlayer2D"

const SONG = preload("res://assets/sounds/song.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	music.stream = SONG
	music.play()

func _process(_delta):
	get_tree().change_scene_to_file("res://infinite-runner/scenes/main.tscn")
