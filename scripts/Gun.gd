extends Area2D
@export var _weapons_resources: Array[WeaponStats]


var fire_rate
var max_time:= 0.1
var time_left := 0.0
var timer_finished = false


func _process(delta):
	if time_left > 0.0:
		time_left -= delta
	elif time_left <= 0.0 and timer_finished == false:
		timer_finished = true
	if Input.is_action_pressed("shoot") and timer_finished == true:
		shoot()
		reset_time_delay()
	look_at(get_global_mouse_position())

func shoot():
	const BULLET = preload("res://scenes/Bullet.tscn")
	var b = BULLET.instantiate()
	%ShootingPoint.add_child(b)
	b.global_transform = %ShootingPoint.global_transform

func reset_time_delay():
	time_left = max_time
	timer_finished = false
