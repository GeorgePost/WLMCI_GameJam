extends Area2D

class_name EnemyBulletFuture
const RIGHT = Vector2.RIGHT
var SPEED: int = 200
@onready var player : CharacterBody2D = $"../Player"

func _physics_process(delta):
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement


func destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_area_entered(area):
	print("area")
	destroy()
	if area.is_in_group("Player"):
		print("movement")
		destroy()


func _on_body_entered(body):
	if body.is_in_group("Player") :
			destroy()
			player.kill()
	elif body.is_in_group("Sword"):
		destroy()
	destroy()
