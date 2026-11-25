extends Area2D

class_name Player

signal player_destroyed

@export var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

@onready var collision_rect: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var bounding_size_x
var start_bound
var end_bound

func _ready() -> void:
	# obter o tamanho horizontal da collision shape
	bounding_size_x = collision_rect.shape.get_rect().size.x
	
	# obter a posicao da extremidade esquerda e direita da tela
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	start_bound = (camera_position.x - rect.size.x) / 2
	end_bound = (camera_position.x + rect.size.x) / 2
	

func _process(delta: float) -> void:
	var input = Input.get_axis("move_left", "move_right")
	
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var delta_movement = speed * delta * direction.x
	
	# se ao aplicar o movimento, a nava sairia do limite da tela, nao faca nada
	if (
		position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x ||
		position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x
	):
		return
	
	position.x += delta_movement
	
func on_player_destroyed():
	speed = 0
	animation_player.play("destroy")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
