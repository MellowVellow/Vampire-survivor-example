extends Node2D

@onready var _animator := $AnimationPlayer

var speed = 750
var max_distance = 2000
var travelled_distance = 0
var attack_damage := 5
var knockback_force := 100


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > max_distance:
		queue_free()
	

func _on_hitbox_component_area_entered(area):
	_animator.play("TakeDamage")
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		hitbox.damage(attack)

