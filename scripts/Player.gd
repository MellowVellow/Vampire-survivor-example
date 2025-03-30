extends CharacterBody2D

signal health_depleted

@onready var health_component = get_node("/root/Main/Player/HealthComponent")
var speed = 1000  # speed in pixels/sec
var dashpower = 500
var forward: Vector2 = Vector2(1,0)

# Player attributes
var level = 1
var experience = 0
var experience_required = get_required_experience(level + 1)
var experience_total = 0
var experienceGainOnEnemyDeath = 100

func _physics_process(delta):
	pass
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("dash"):
		dash()
	
	if velocity.length() > 0.0:
		get_node("HappyBoo").play_walk_animation()
	else:
		get_node("HappyBoo").play_idle_animation()
	
	%ProgressBar.max_value = health_component.MAX_HEALTH
	%ProgressBar.value = health_component.health
	if health_component.health <= 0.0:
		health_depleted.emit()
		#emit signal for play ui to display game over
			

func dash():
	var olddir = self.position
	const SMOKE_SCENE = preload("res://assets/smoke_explosion/smoke_explosion.tscn")
	
	if velocity.length() > 0.0:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var dashdir = direction * dashpower
		self.position += dashdir
		var smoke = SMOKE_SCENE.instantiate()
		smoke.position = olddir
		add_sibling(smoke)
	else:
		var dashdir = forward * dashpower
		self.position += dashdir
	

func gain_experience(enemyExperience: int):
	experience += enemyExperience
	experience += enemyExperience
	while experience >= experience_required:
		experience -= experience_required
		level_up()

func level_up():
	level += 1
	experience_required = get_required_experience(level + 1)
	# Additional logic for level up such as increasing stats, unlocking abilities, etc.
	print("Level up! You are now level ", level)

# Function to calculate the amount of XP required to reach the next level
func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)

# Example function to simulate an enemy being defeated and giving XP to the player
func simulateEnemyDefeat():
	gain_experience(experienceGainOnEnemyDeath)
