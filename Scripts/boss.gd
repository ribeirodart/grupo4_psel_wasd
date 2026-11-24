extends Area2D

@export var speed: float = 200.0
@export var hp: int = 30

var movement_direction = 1

const LEFT_WALL_BOUND_POS: float = 815.0
const RIGHT_WALL_BOUND_POS: float = 334.0

@onready var shooting_timer: Timer = %ShootingTimer
@onready var laser_scene = preload("res://Scenes/invader_shot.tscn")

# pontos de tiro onde o tiro do boss pode sair
@onready var shooting_point_1: Marker2D = %ShootingPoint1
@onready var shooting_point_2: Marker2D = %ShootingPoint2
@onready var shooting_point_3: Marker2D = %ShootingPoint3
@onready var shooting_point_4: Marker2D = %ShootingPoint4
@onready var shooting_point_5: Marker2D = %ShootingPoint5

@onready var shooting_points: Array[Marker2D]

func _ready() -> void:
	shooting_points = [shooting_point_1, shooting_point_2, shooting_point_3, shooting_point_4, shooting_point_5]

func _process(delta: float) -> void:
	global_position.x += speed * delta * movement_direction
	
	if position.x > LEFT_WALL_BOUND_POS:
		movement_direction *= -1
		
	if position.x < RIGHT_WALL_BOUND_POS:
		movement_direction *= -1

func _on_shooting_timer_timeout() -> void:
	shooting_timer.start()
	var random_point = shooting_points.pick_random()
	var laser = laser_scene.instantiate()
	laser.global_position = random_point.position
	get_tree().root.add_child(laser)
	
