extends Area2D

# remover balas do jogo quando elas cruzam a tela
func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
