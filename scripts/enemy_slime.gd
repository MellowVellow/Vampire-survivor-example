extends CharacterBody2D

@onready var player = get_node("/root/Main/Player")
@onready var damage_numbers_origin = $DamageNumbersOrigin

var enemy_speed = 300
var attack_damage := 10
var knockback_force := 10
var is_critical: bool

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * enemy_speed
	move_and_slide()

func _on_hitbox_component_area_entered(area):
	if area.get_parent().name == "Player":
		pass
	else:
		%Slime.play_hurt()
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		hitbox.damage(attack)
		DamageNumbers.display_number(attack_damage, damage_numbers_origin.global_position, is_critical)
