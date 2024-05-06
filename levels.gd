extends Control

var level1
var level2
var level3

func _ready():
	if level1:
		$Level2.disabled = false
	if level2:
		$Level3.disabled = false
	if level3:
		$Level4.disabled = false

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://levels/level1/scenes/level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://levels/level2/scenes/level2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://levels/level3/scenes/level3.tscn")

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://levels/leve4/scenes/level4.tscn")
