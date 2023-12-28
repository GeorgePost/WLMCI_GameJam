extends State
class_name DashState

@onready var timer = $Timer
@onready var Boss1 = $"../.."

func transition():
	if ray_cast.is_colliding():
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
