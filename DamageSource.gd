extends Node
class_name DamageSource

enum DamageElement {
	Physical,
	Fire,
	Water
}

var damage : int
var element: DamageElement
var knockback : Vector2
var can_kill : bool
var can_be_blocked : bool = true
var can_crit : bool = true
var manaburn : int = 0

func _init(_damage = 1, _element = DamageElement.Physical,
			_knockback = Vector2.ZERO, _can_kill = true, _can_be_blocked = true,
			_can_crit = true, _manaburn = 0) -> void:
	pass
	

## example
#func take_damage(damage_source : DamageSource) -> void:
	#health -= damage_source.damage
	#if health <= 0:
		#if damage_source.can_kill:
			#die()
		#else:
			#health = 1
		#else:
			#if damage_source.element == DamageSource.DamageElement.Fire:
				#burn()
			#react_to_damage(damage_source)
#
#func react_to_damage(damage_source : DamageSource) -> void:
	#pass

