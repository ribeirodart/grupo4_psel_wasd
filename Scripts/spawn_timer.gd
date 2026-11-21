extends Timer

## Classe para definir um temporizador aleatorio entre o minimo min_time e o maximo max_time
class_name SpawnTimer

@export var min_time: int = 5
@export var max_time: int = 10

func _ready() -> void:
	setup_timer()
	
func setup_timer():
	var random_time = randi_range(min_time, max_time)
	self.wait_time = random_time
	# reiniciar o timer
	self.stop()
	self.start()
