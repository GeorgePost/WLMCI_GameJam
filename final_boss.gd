extends CharacterBody2D
 
@onready var ray_cast = $RayCast2D
@onready var player : CharacterBody2D = $"../Player"
@onready var progress_bar = $ProgressBar
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@onready var color_rect = $Alive/ColorRect
@onready var hit_box = $HitBox
@onready var collision_shape_2d = $HurtBox/CollisionShape2D
@onready var enemy_scene1 = preload("res://enemy.tscn")
@onready var enemy_scene2 = preload("res://enemy_future.tscn")
@onready var dead = false
var randNumber = 0

var health: = 100:
	set(value):
		health = value
		progress_bar.value = value
 
var direction = Vector2.RIGHT
var speed  = 170.0
 
func _ready():
	effects.play("RESET")
	set_physics_process(false)
 
func _process(_delta):
	direction = (player.position - global_position).normalized()
	ray_cast.target_position = direction * 500
 
func _physics_process(delta):
	var dir_to_player = global_position.direction_to(player.global_position)

	velocity = dir_to_player * speed
	move_and_slide()
	
	global_rotation = dir_to_player.angle() + PI/2.0
	
	var angle_to_target: float = global_position.direction_to(player.global_position).angle()
	ray_cast.global_rotation = angle_to_target
 
func _input(event):
	if event.is_action_pressed("test"):
		health -= 1
		
func _on_hurt_box_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		$Hit.play()
		if area == $HitBox: return
		if Global.weaponEquipped == "sword":
			health -= 2
		elif Global.weaponEquipped == "gun":
			health -= 2
		if health <= 0:
			kill()
		color_rect.visible = true
		effects.play("hurtBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		color_rect.visible = false

func kill():
	Global.enemies -= 1
	$".".queue_free()
	dead = true
	$Alive.hide()
	hit_box.disabled = true
	collision_shape_2d.disabled = true
	z_index = -1


func _on_spawn_timer_timeout():
	Global.enemies += 1
	randNumber = randi_range(0,1)
	var enemy
	if randNumber == 0:
		enemy = enemy_scene1.instantiate()
	else:
		enemy = enemy_scene2.instantiate()
	enemy.position = Vector2(randf_range(global_position.x-200, global_position.x+200), randf_range(global_position.y-200, global_position.y+200))
	get_tree().current_scene.add_child(enemy)
