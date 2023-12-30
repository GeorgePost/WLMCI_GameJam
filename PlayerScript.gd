extends CharacterBody2D

@onready var player = $"."
@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 200
@onready var animations = $AnimationPlayer
@onready var sword = $Weapon/Sword
@onready var waterGun1 = $Weapon/WaterGun1
@onready var weapon = $Weapon
var isAttacking: bool = false
var dead = false
var bullet_speed = 2000
var fire_rate = 0.2
var bullet = preload("res://Weapons/bullet.tscn")
@onready var transition = $CanvasLayer/TransitionPanel
var can_fire = true
var vect = Vector2(0.0, -500.0)
var bosses = [$"../Boss1", $"../Boss1", $"../FinalBoss"]


func _ready():
	if Global.count <= 5:
		$PastMusic.play()
	elif Global.count <= 10:
		$FutureMusic.play()
	elif Global.count <= 15:
		$PresentMusic.play()
	animations.play("RESET")
	sword.visible = false
	waterGun1.visible = false


func _process(delta):
	if Global.count >= 6:
		Global.weaponEquipped = "gun"
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if dead:
		return
	
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	if Input.is_action_just_pressed("attack"):
		if Global.weaponEquipped == "gun":
			waterGun1.visible = true
			sword.visible = false
			sword.disable()
			shoot()
		elif Global.weaponEquipped == "sword":
			sword.visible = true
			sword.enable()
			waterGun1.visible = false
			swing()

func _physics_process(delta):
	if dead:
		return
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_dir * move_speed
	move_and_slide()

func swing():
	$Swing.play()
	animations.play("AttackDown")
	isAttacking = true
	weapon.enable()
	await animations.animation_finished
	weapon.disable()
	sword.disable()
	isAttacking = false	

func kill():
	if dead:
		return
	dead = true
	$Death.play()
	$Graphics/Alive.hide()
	$CanvasLayer/Deathscreen.show()
	z_index = -1

func restart():
	get_tree().reload_current_scene()

func shoot():
	$Laser.play()
	var bullet_instance = bullet.instantiate() 
	get_tree().root.add_child(bullet_instance)
	
	var move_direction = (get_global_mouse_position() - global_position).normalized()
	bullet_instance.move_direction = move_direction
	bullet_instance.global_position = global_position
	bullet_instance.rotation = move_direction.angle()

func _on_door_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if Global.count == 5:
		Global.count += 1
		if dead:
			return
		dead = true
		transition.changeText("You've altered history and now it's time to leap forward!\n
									Upon arriving in the future, you discover a water gun,\n
									surprisingly potent against the robotic foes that await!")
		transition.changeScene("res://level_" + str(Global.count) + ".tscn")
		transition.show()
		z_index = -1
	elif Global.count == 10:
		Global.count += 1
		if dead:
			return
		dead = true
		transition.changeText("Now, return to the present for the ultimate showdown!\n
							Armed with knowledge from past and future, face the final boss\n
							in a decisive battle that will determine the fate of the world. ")
		transition.changeScene("res://level_" + str(Global.count) + ".tscn")
		transition.show()
		z_index = -1
	elif Global.count == 15:
		Global.count += 1
		if dead:
			return
		dead = true
		transition.changeText("Victory! With the final boss defeated, peace is restored.\n
								As the world heals, your journey across time\n
								leaves a legacy of hope and courage. The future, once grim,\n
								now shines brightly thanks to your valiant efforts.
								\nThank you for playing our game!\nCreated by:\nGeorge P.\nKevin K.")
		transition.changeScene("res://menu.tscn")
		transition.show()
		z_index = -1
	elif Global.count == 0:
		Global.count += 1
		if dead:
			return
		dead = true
		transition.changeText("Dr. Tim E., an aged scientist, cracks time travel to stop 'The Malefactor,'\n 
								a villain ravaging the future. As the clock ticks,\n
								you must outwit history itself and change destiny.\n
								The future is in your hands - the journey begins now!")
		transition.changeScene("res://level_" + str(Global.count) + ".tscn")
		transition.show()
		z_index = -1
	else:
		Global.count += 1
		get_tree().change_scene_to_file("res://level_" + str(Global.count) + ".tscn") # Replace with function body.

	


func transitionFunc():
	if dead:
		return
	dead = true
	if Global.bossNum == 0:
		transition.changeText("You have completed the first level!\nCongratulations Idk sadhasoh iuhfsualdhfl")
	elif Global.bossNum == 1:
		transition.changeText("You have completed the second level!\nCongratulations Idk sadhasoh iuhfsualdhfl")
	elif Global.bossNum == 2:
		transition.changeText("You have completed the game!\nCongratulations Idk sadhasoh iuhfsualdhfl")
	transition.show()
	Global.bossNum += 1
	z_index = -1
