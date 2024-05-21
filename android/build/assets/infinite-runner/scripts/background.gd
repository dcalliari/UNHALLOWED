extends ParallaxBackground

const CENARIO_1_FUNDO = preload("res://assets/img/background/cenario_1_fundo.png")
const CENARIO_1_MONTANHA_COSTAS = preload("res://assets/img/background/cenario_1_montanha_costas.png")
const CENARIO_1_MONTANHA_FRENTE = preload("res://assets/img/background/cenario_1_montanha_frente.png")

const CENARIO_2_FUNDO = preload("res://assets/img/background/cenario_2_fundo.png")
const CENARIO_2_OLHO = preload("res://assets/img/background/cenario_2_olho.png")
const CENARIO_2_MONTANHAS = preload("res://assets/img/background/cenario_2_montanhas.png")
const CENARIO_2_ILHAS = preload("res://assets/img/background/cenario_2_ilhas.png")

const CENARIO_3_FUNDO = preload("res://assets/img/background/cenario_3_fundo.png")
const CENARIO_3_PILARES_TRAS = preload("res://assets/img/background/cenario_3_pilares_tras.png")
const CENARIO_3_PILARES_FRENTE = preload("res://assets/img/background/cenario_3_pilares_frente.png")

@onready var sprite_fundo = $Fundo/SpriteFundo
@onready var sprite_olho = $Olho/SpriteOlho
@onready var sprite_montanhas = $Montanhas/SpriteMontanhas
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
		sprite_fundo.set_texture(CENARIO_1_FUNDO)
		sprite_olho.set_texture(null)
		sprite_montanhas.set_texture(CENARIO_1_MONTANHA_COSTAS)
		sprite_montanhas_frente.set_texture(CENARIO_1_MONTANHA_FRENTE)
	
	if main.level == 1:
		sprite_fundo.set_texture(CENARIO_2_FUNDO)
		sprite_olho.set_texture(CENARIO_2_OLHO)
		sprite_montanhas.set_texture(CENARIO_2_MONTANHAS)
		sprite_montanhas_frente.set_texture(CENARIO_2_ILHAS)

	if main.level == 2:
		sprite_fundo.set_texture(CENARIO_3_FUNDO)
		sprite_olho.set_texture(null)
		sprite_montanhas.set_texture(CENARIO_3_PILARES_TRAS)
		sprite_montanhas_frente.set_texture(CENARIO_3_PILARES_FRENTE)
