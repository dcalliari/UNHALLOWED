extends StaticBody2D

const CENARIO_1_CHAO = preload("res://assets/img/cenario_1_chao.png")
const CENARIO_2_CHAO = preload("res://assets/img/cenario_2_chao.png")
const CENARIO_3_CHAO = preload("res://assets/img/cenario_3_chao.png")

@onready var main = $"/root/Main"
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if main.level == 0:
		sprite.set_texture(CENARIO_1_CHAO)
	if main.level == 1:
		sprite.set_texture(CENARIO_2_CHAO)
	if main.level ==2:
		sprite.set_texture(CENARIO_3_CHAO)
