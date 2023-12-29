extends Area2D

class_name EnemyBulletExplosion
const RIGHT = Vector2.RIGHT
var SPEED: int = 200
@onready var player : CharacterBody2D = $"../Player"
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var explosion_shape = $ExplosionShape
@onready var explosionShape = $Explosion
@onready var sprite_2d_2 = $Sprite2D2

func _ready():
	explosion_shape.disabled = true
	explosionShape.visible = false

func _physics_process(delta):
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement


func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_area_entered(area):
	print("area")
	if area.is_in_group("Player"):
		print("movement")
		destroy()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$Explosion2.play()
		sprite_2d_2.visible = false
		explosionShape.visible = true
		animation_player.play("Explosion")
		await animation_player.animation_finished
		explosion_shape.disabled = false
		destroy()
		player.kill()
	destroy()

func _on_timer_timeout():
	$Explosion2.play()
	sprite_2d_2.visible = false
	explosionShape.visible = true
	animation_player.play("Explosion")
	await animation_player.animation_finished
	explosion_shape.disabled = false
	destroy()
