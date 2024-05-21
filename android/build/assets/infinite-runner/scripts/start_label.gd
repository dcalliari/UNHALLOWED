extends Label

@onready var main = $"/root/Main"

func _ready():
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
	remove_child(main)

func _on_button_2_pressed():
	main.retry()
