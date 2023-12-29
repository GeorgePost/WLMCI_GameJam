extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$ThemeMusic.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.d


func _on_start_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn") # Replace with function body.


func _on_quit_pressed():
	get_tree().quit();
