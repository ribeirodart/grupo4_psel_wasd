extends CanvasLayer

# Codigo pro menu inicial do jogo

# referencias pros aliens
@onready var invader_1_texture: TextureRect = %Invader1Texture
@onready var invader_1_label: Label = %Invader1Label
@onready var invader_2_texture: TextureRect = %Invader2Texture
@onready var invader_2_label: Label = %Invader2Label
@onready var invader_3_texture: TextureRect = %Invader3Texture
@onready var invader_3_label: Label = %Invader3Label

# referencia pro timer
@onready var timer: Timer = %Timer

# array para armazenar os elementos dos aliens
var control_array: Array[Control] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	control_array.append_array([invader_1_texture, invader_1_label, invader_2_texture, invader_2_label, invader_3_texture, invader_3_label])
	
	for control in control_array:
		(control as Control).modulate = Color.TRANSPARENT


# executada quando o botao de jogar eh pressionado
func load_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

# executada quando o timer termina
func show_next_control() -> void:
	# percorre a lista dos elementos de UI dos aliens e os torna visiveis
	# se a lista estiver vazia, entao deleta o timer da arvore
	var control: Control = control_array.pop_front() as Control
	if control != null:
		control.modulate = Color.WHITE
	else:
		timer.stop()
		timer.queue_free()
