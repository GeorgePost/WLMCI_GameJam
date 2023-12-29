extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D
var health = 100	
var knockbackPower: int = 10
@export var move_speed = 100
@onready var player : CharacterBody2D = $"../Player"
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
signal lostEnemy()
var seePlayer = false

var dead = false
func _ready():
	effects.play("RESET")

func _physics_process(delta):
	if dead or player == null:
		return
	
	var dir_to_player = global_position.direction_to(player.global_position)
	if seePlayer:
		velocity = dir_to_player * move_speed
	move_and_slide()
	global_rotation = dir_to_player.angle() + PI/2.0
	
	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		player.kill()

func kill():
	$".".queue_free()
	dead = true
	emit_signal("lostEnemy")
	$Graphics/Alive.hide()
	$HitBox.disabled = true
	$HurtBox/CollisionShape2D.disabled = true
	z_index = -1


func _on_hurt_box_area_entered(area):
	if area.is_in_group("PlayerBullet") || area.is_in_group("Sword"):
		$Hit.play()
		if area == $HitBox: return
		if player.weaponEquipped == "sword":
			health -= 20
		elif player.weaponEquipped == "gun":
			health -= 30
		if health <= 0:
			kill()
		knockback()
		effects.play("hurtBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("RESET")
	
func knockback():
	var knockbackDirection = (velocity) * -knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		seePlayer = true
