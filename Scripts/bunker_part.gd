extends Area2D

@export var sprite: Sprite2D
@export var texture_array: Array[Texture2D]

var damage: int = 0
const MAX_DAMAGE: int = 3

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	
# Nao eh um sinal. 
func _on_area_entered(area):
	if area is Laser or area is InvaderShot:
		area.queue_free()
		if damage < MAX_DAMAGE:
			damage += 1
			# atualizar o sprite do bunker
			sprite.texture = texture_array[damage - 1]
		else:
			queue_free()
			
	if area is Invader:
		queue_free()
