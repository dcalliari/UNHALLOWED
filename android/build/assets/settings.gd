extends Control

@onready var check_button = $ColorRect/VBoxContainer/CheckButton

var mobile_mode
var save_path = "user://first_time.save"

func _ready():
	load_data()
	print(mobile_mode)
	check_button.button_pressed = mobile_mode

func _on_check_button_toggled(toggled_on):
	mobile_mode = toggled_on
	save_data()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(mobile_mode)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		mobile_mode = file.get_var()
	else:
		mobile_mode = false
