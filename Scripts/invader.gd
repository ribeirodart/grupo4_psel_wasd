extends Area2D

class_name Invader
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var config: Resource

func _ready() -> void:
	sprite_2d.texture = config.sprite
	animation_player.play(config.animation_name)

# verificar colisoes com o laser
func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		animation_player.play("destroy")
		area.queue_free()

# remover o alien do jogo depois de tocar a animacao de destruir
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		queue_free()
