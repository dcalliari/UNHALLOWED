extends Node

@onready var music = $"/root/Music/AudioStreamPlayer2D"

const SONG = preload("res://assets/sounds/song.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	music.stream = SONG
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().change_scene_to_file("res://infinite-runner/scenes/main.tscn")
