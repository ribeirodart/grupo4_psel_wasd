extends Area2D

class_name Laser

@export var speed: float = 700.0

func _process(delta: float) -> void:
	position.y -= delta * speed
