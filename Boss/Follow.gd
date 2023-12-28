extends State
class_name FollowState
#var distance_to = player.position.distance_to(global_position)
@onready var player : CharacterBody2D = $"../../../Player"


func transition():
	var xValue = abs(player.position.x-global_position.x)
	var yValue = abs(player.position.x-global_position.x)
	var readyShoot = xValue <= 350 && yValue <= 350
	if readyShoot:
		get_parent().change_state("Shoot")

func enter():
	super.enter()
	owner.set_physics_process(true)

func exit():
	super.exit()
	owner.set_physics_process(false)
