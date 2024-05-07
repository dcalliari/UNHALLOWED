extends Control

var first_time: bool

var save_path = "user://first_time.save"

func _ready():
	load_data()

func _on_start_pressed():
	if first_time:
		get_tree().change_scene_to_file("res://levels/level1/scenes/level1.tscn")
		first_time = false
		save_data()
	else:
		get_tree().change_scene_to_file("res://levels.tscn")

func _on_infinite_pressed():
	get_tree().change_scene_to_file("res://worlds.tscn")

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
