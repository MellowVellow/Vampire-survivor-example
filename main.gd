extends Node2D
@onready var player = $Player
@onready var _label = $Interface/Label
@onready var experience_bar = $Interface/ExperienceBar

func _process(delta):
	experience_bar.max_value = player.experience_required
	experience_bar.value = player.experience

func _on_timer_timeout():
	spawn_mob()


func spawn_mob():
	var new_mob = preload("res://scenes/enemy_slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	

func _ready():
	#_bar.initialize(player.experience, player.experience_required)
	_label.update_text(player.level, player.experience, player.experience_required)

func _input(event):
	if not event.is_action_pressed('ui_accept'):
		return
	player.gain_experience(33)
	_label.update_text(player.level, player.experience, player.experience_required)


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
