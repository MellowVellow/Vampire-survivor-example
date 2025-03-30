extends Camera2D

@export var speed = 10
@onready var player = get_node("/root/Main/Player")

func _physics_process(delta):
	position = lerp(position, player.position, speed * delta)
