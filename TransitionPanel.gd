extends Control

@export var dialogue_text = "Default text"
@export var sceneToTransition = "res://World.tscn"
@onready var text_label = $Panel/Label

func _ready():
	text_label.text = dialogue_text

func _physics_process(delta):
	text_label.text = dialogue_text
	
	
func changeText(text):
	dialogue_text = text
func changeScene(scene):
	sceneToTransition = scene


func _on_button_button_up():
	get_tree().change_scene_to_file(sceneToTransition) # Replace with function body.
