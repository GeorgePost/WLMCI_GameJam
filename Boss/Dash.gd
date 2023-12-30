extends State

@onready var timer = $Timer
@onready var Boss1 = $"../.."
@onready var player : CharacterBody2D = $"../../../Player"

func transition():
	var xValue = abs(player.position.x-global_position.x)
	var yValue = abs(player.position.y-global_position.y)
	var readyShoot = xValue <= 350 && yValue <= 350
	if readyShoot:
			get_parent().change_state("Shoot")
		

func dash():
	if Boss1.dead:
		return
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.75)

func _on_timer_timeout():
	dash()

func enter():
	super.enter()
	timer.start()

func exit():
	print("bruh")
	super.exit()
	timer.stop()
