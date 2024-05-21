extends Control

var first_time: bool

var save_path = "user://first_time.save"

@onready var music = $"/root/Music/AudioStreamPlayer2D"
const SONG = preload("res://assets/sounds/song.wav")
const MENU = preload("res://assets/sounds/menu.wav")
func _ready():
	if music.stream == SONG:
		music.stream = MENU
		music.play()
		
	load_data()

func _on_start_pressed():
	if first_time:
		# TODO: show instructions
		get_tree().change_scene_to_file("res://bg_music.tscn")
	if not first_time:
		get_tree().change_scene_to_file("res://bg_music.tscn")

func _on_quit_pressed():
	get_tree().quit()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(first_time)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		first_time = file.get_var()
	else:
		first_time = true

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")
