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
