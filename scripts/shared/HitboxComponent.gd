extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

func damage(attack: AttackComponent):
	if health_component:
		health_component.take_damage(attack)
		

