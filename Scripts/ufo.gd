extends Area2D

class_name Ufo

@export var speed: int = 200
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= delta * speed


# remover o ufo da tela quando ele sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
