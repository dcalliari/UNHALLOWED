extends Control

var level4: bool

func _ready():
	if FileAccess.file_exists("user://level4.save"):
		var file = FileAccess.open("user://level4.save", FileAccess.READ)
		level4 = file.get_var()
		if level4:
			$World1.disabled = false

func _on_world_1_pressed():
	get_tree().change_scene_to_file("res://worlds/world1/scenes/world1.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
