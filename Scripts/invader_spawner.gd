extends Node2D

class_name InvaderSpawner

# informacoes do spawner
const ROWS: int = 5
const COLUMNS: int = 11
const HORIZONTAL_SPACING: int = 32
const VERTICAL_SPACING: int = 32
const INVADER_HEIGHT: int = 24
const START_Y_POSITION: int = -50
const INVADERS_POSITION_X_INCREMENT: int = 10
const INVADERS_POSITION_Y_INCREMENT: int = 20

var movement_direction: int = 1
var invader_scene = preload("res://Scenes/invader.tscn")
var invader_shot_scene = preload("res://Scenes/invader_shot.tscn")

# referencias pro no
@onready var movement_timer: Timer = $MovementTimer
@onready var shot_timer: Timer = $ShotTimer

func _ready() -> void:
	# setup dos timers
	# essa linha faz os invasores se moverem de acordo com o intervalo "Wait Time"
	# do no "MovementTimer"
	movement_timer.timeout.connect(move_invaders)
	shot_timer.timeout.connect(on_invader_shot)
	
	
	var invader_1_res = preload("res://Resources/invader_1.tres")
	var invader_2_res = preload("res://Resources/invader_2.tres")
	var invader_3_res = preload("res://Resources/invader_3.tres")
	
	var invader_config
	
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 or row == 2:
			invader_config = invader_2_res
		elif row == 3 or row == 4:
			invader_config = invader_3_res
		
		# calcula a largura da linha
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		# posicao da primeira linha
		var start_x = (position.x - row_width) / 2
		
		for col in COLUMNS:
			# calcular a posicao de spawn do invader
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x, y)
			
			spawn_invader(invader_config, spawn_position)
			

# funcao pra spawnar um invader
func spawn_invader(invader_config, spawn_position: Vector2) -> void: 
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_position
	add_child(invader)
	

func move_invaders():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction


func _on_right_wall_area_entered(_area: Area2D) -> void:
	if movement_direction == 1:
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1


func _on_left_wall_area_entered(_area: Area2D) -> void:
	if movement_direction == -1:
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1
		
func on_invader_shot():
	# obtem os filhos, filtra os filhos para pegar somente os invasores (movement timer e shot timer tambem sao filhos, por isso o filtro)
	# em seguida pega a posicao de um filho aleatorio e o armazena na variavel random_child_position
	var random_child_position = get_children().filter(func (child): return child is Invader).map(func (invader): return invader.global_position).pick_random()
	
	var invader_shot = invader_shot_scene.instantiate() as InvaderShot
	invader_shot.global_position = random_child_position
	
	get_tree().root.add_child(invader_shot)
	
