extends Area2D

class_name InvaderShot

@export var speed: float = 200

func _process(delta: float) -> void:
	position.y += speed * delta

# remover o projetil quando ele sair da tela
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area.on_player_destroyed()
		queue_free()
