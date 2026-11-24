extends Node

class_name PointsCounter

signal on_points_increased(points: int)

var points: int = 0

@onready var invader_spawner: InvaderSpawner = %InvaderSpawner

func _ready() -> void:
	invader_spawner.invader_destroyed.connect(increase_points)
	
func increase_points(points_to_add: int) -> void:
	points += points_to_add
	on_points_increased.emit(points)
	
