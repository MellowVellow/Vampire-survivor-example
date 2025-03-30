extends Node2D
class_name HealthComponent


@export var MAX_HEALTH := 10
var velocity #???
var health : float

func _ready():
	health = MAX_HEALTH

func take_damage(attack: AttackComponent):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()
		const SMOKE_SCENE = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
	velocity = (global_position - attack.attack_position).normalized()*attack.knockback_force

