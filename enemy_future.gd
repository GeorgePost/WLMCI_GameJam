extends CharacterBody2D

@export var Bullet: PackedScene = null

@onready var ray_cast_2d = $RayCast2D
var health = 100
var knockbackPower: int = 10
@export var move_speed = 100
@onready var player : CharacterBody2D = $"../Player"
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@onready var reloadTimer = $RayCast2D/ReloadTimer
var enemyBullet = preload("res://enemy_bullet.tscn")
var seePlayer = false
var target: Node2D = null
var dead = false
func _ready():
	effects.play("hurtBlink")


func _physics_process(delta):
	if dead or player == null:
		return
	
	var dir_to_player = global_position.direction_to(player.global_position)
	
	velocity = dir_to_player * move_speed
	move_and_slide()
	
	global_rotation = dir_to_player.angle() + PI/2.0
	
	var angle_to_target: float = global_position.direction_to(player.global_position).angle()
	ray_cast_2d.global_rotation = angle_to_target

	

	if reloadTimer.is_stopped():
		shoot()


func kill():
	Global.enemies -= 1
	$".".queue_free()
	dead = true
	$Graphics/Alive.hide()
	$HitBox.disabled = true
	$HurtBox/CollisionShape2D.disabled = true
	z_index = -1


func _on_hurt_box_area_entered(area):
	if area.is_in_group("PlayerBullet") || area.is_in_group("Sword"):
		$Hit.play()
		if area == $HitBox: return
		if Global.weaponEquipped == "sword":
			health -= 20
		elif Global.weaponEquipped == "gun":
			health -= 30
		if health <= 0:
			kill()
		knockback()
		effects.play("RESET")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("hurtBlink")
	
func knockback():
	var knockbackDirection = (velocity) * -knockbackPower
	velocity = knockbackDirection
	move_and_slide()
func _on_ReloadTimer_timeout():
	ray_cast_2d.enabled = true

func shoot():
	if !player.dead:
		$Gun.play()
	ray_cast_2d.enabled = false
	
	var bullet = enemyBullet.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = ray_cast_2d.global_rotation
	
	reloadTimer.start()


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		seePlayer = true
