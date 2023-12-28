extends State
class_name ShootState

@export var enemy_bullet_node : PackedScene 
@onready var timer = $Timer
var enemyBullet = preload("res://enemy_bullet.tscn")
@onready var Boss1 = $"../.."

func transition():
	if not ray_cast.is_colliding():
		if owner.health >= 50:
			get_parent().change_state("Follow")
		elif owner.health <= 50:
			get_parent().change_state("Dash")

func enter():
	super.enter()
	timer.start()

func exit():
	super.exit()
	timer.stop()


func _on_timer_timeout():
	var dir_to_player = global_position.direction_to(player.global_position)
	global_rotation = dir_to_player.angle() + PI/2.0
	
	var angle_to_target: float = global_position.direction_to(player.global_position).angle()
	ray_cast.global_rotation = angle_to_target
	shoot()

func shoot():
	if Boss1.dead:
		return
	var bullet = enemyBullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = ray_cast.global_rotation
