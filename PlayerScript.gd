extends CharacterBody2D

const max_speed=400 
const acceleration=1500
const friction = 600
var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	rotate(-90)

func get_input():
	look_at(get_global_mouse_position());
	input.x= (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	input.y=int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_movement(delta):
	input=get_input()
	
	if input == Vector2.ZERO:
		if velocity.length()> (friction*delta):
			velocity-=velocity.normalized() * (friction*delta)
		else:
			velocity=Vector2.ZERO
	else:
		velocity+=(input*acceleration*delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()
