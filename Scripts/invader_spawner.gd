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

func _ready() -> void:
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
	
	
