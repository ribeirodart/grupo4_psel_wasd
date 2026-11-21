extends Node2D

# referencia pra cena do laser
@export var laser_scene: PackedScene

# controle para determinar se o jogador pode atirar
var can_player_shoot: bool = true

# processa input do jogador
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and can_player_shoot:
		can_player_shoot = false
		# instanciar o laser
		var laser = laser_scene.instantiate() as Laser
		# setar a posicao inicial do laser
		laser.global_position = get_parent().global_position - Vector2(0, 20)
		# adicionar o laser a arvore do jogo
		get_tree().root.get_node("main").add_child(laser)
		laser.tree_exited.connect(on_laser_destroyed)


func on_laser_destroyed() -> void:
	can_player_shoot = true
