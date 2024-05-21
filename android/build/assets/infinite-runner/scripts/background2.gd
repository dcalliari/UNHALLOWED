extends ParallaxBackground

const CENARIO_3_PILARES_FRENTE = preload("res://assets/img/background/cenario_3_pilares_frente.png")

@onready var sprite_montanhas_frente = $MontanhasFrente/SpriteMontanhasFrente

@onready var main = $"/root/Main"
@onready var player = $"/root/Main/Player"


func _ready():
	pass

func _physics_process(delta):
	if not player.active:
		return
	var speed = main.speed() / 10
	scroll_base_offset -= Vector2(speed, 0) * delta

	if main.level == 0:
		sprite_montanhas_frente.set_texture(null)
	if main.level == 1:
		sprite_montanhas_frente.set_texture(null)
	if main.level == 2:
		sprite_montanhas_frente.set_texture(CENARIO_3_PILARES_FRENTE)
