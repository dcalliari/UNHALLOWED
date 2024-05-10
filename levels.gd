extends Control

var level1: bool
var level2: bool
var level3: bool

func _ready():
	if FileAccess.file_exists("user://level1.save"):
		var file = FileAccess.open("user://level1.save", FileAccess.READ)
		level1 = file.get_var()
		if level1:
			$Level2.disabled = false
	if FileAccess.file_exists("user://level2.save"):
		var file = FileAccess.open("user://level2.save", FileAccess.READ)
		level2 = file.get_var()
		if level2:
			$Level3.disabled = false
	if FileAccess.file_exists("user://level3.save"):
		var file = FileAccess.open("user://level3.save", FileAccess.READ)
		level3 = file.get_var()
		if level3:
			$Level4.disabled = false

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://levels/level1/scenes/level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://levels/level2/scenes/level2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://levels/level3/scenes/level3.tscn")

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://levels/level4/scenes/level4.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
