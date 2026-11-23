extends Area2D

class_name Ufo

@export var speed: int = 200
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var shooting_point: Node2D = $ShootingPoint
var explosion_texture = preload("res://Assets/Ufo/Ufo-explosion.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= delta * speed


# remover o ufo da tela quando ele sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		shooting_point.queue_free()
		speed = 0
		sprite_2d.texture = explosion_texture
		# aguardar 1,5 segundos antes de remover o ufo da arvore
		await get_tree().create_timer(1.5).timeout
		queue_free()
		
		
		
		
