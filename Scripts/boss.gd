extends Area2D

@export var speed: float = 200.0
@export var hp: int = 30

var movement_direction = 1

const LEFT_WALL_BOUND_POS: float = -230.0
const RIGHT_WALL_BOUND_POS: float = 230.0

@onready var shooting_timer: Timer = %ShootingTimer
@onready var laser_scene = preload("res://Scenes/invader_shot.tscn")

# pontos de tiro onde o tiro do boss pode sair
@onready var shooting_point_1: Node2D = %ShootingPoint1
@onready var shooting_point_2: Node2D = %ShootingPoint2
@onready var shooting_point_3: Node2D = %ShootingPoint3
@onready var shooting_point_4: Node2D = %ShootingPoint4
@onready var shooting_point_5: Node2D = %ShootingPoint5

@onready var shooting_points: Array[Node2D]

func _ready() -> void:
	print("BOSS HP: ", str(hp))

func _process(delta: float) -> void:
	global_position.x += speed * delta * movement_direction
	
	if position.x > LEFT_WALL_BOUND_POS:
		movement_direction *= -1
		
	if position.x < RIGHT_WALL_BOUND_POS:
		movement_direction *= -1
		
	shooting_points = [shooting_point_1, shooting_point_2, shooting_point_3, shooting_point_4, shooting_point_5]

func _on_shooting_timer_timeout() -> void:
	shooting_timer.start()
	var random_point = shooting_points.pick_random()
	var laser = laser_scene.instantiate()
	# TODO: consertar posicao e escala do laser
	# laser.top_level = true
	laser.position = random_point.position
	# sobreescrever escala do laser
	laser.scale = Vector2(0.5, 0.5)
	add_child(laser)
	

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		area.queue_free()
		print("BOSS HP: ", str(hp))
		hp -= 1
		if hp == 0:
			queue_free()
