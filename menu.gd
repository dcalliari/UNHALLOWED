extends Control

var first_time = false

func _ready():
	pass

func _on_start_pressed():
	if first_time:
		get_tree().change_scene_to_file("res://levels.tscn")
	else:
		get_tree().change_scene_to_file("res://levels/level1/scenes/level1.tscn")

func _on_infinite_pressed():
	get_tree().change_scene_to_file("res://levels/infinite/scenes/infinite.tscn")

func _on_quit_pressed():
	get_tree().quit()
