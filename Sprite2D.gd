extends Sprite2D

var char_tex = load("res://Sprites/Lu2.png") 

func _ready():
	set_texture(char_tex)

func _input(event):
	if event is InputEventMouseButton:
		char_tex = load("res://Sprites/Lu1.png")
