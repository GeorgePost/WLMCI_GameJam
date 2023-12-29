extends Area2D
var levelComplete=false;
var number_of_enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_enemies = get_tree().get_nodes_in_group("Enemy").size()
	hide(); #Hide the door


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(number_of_enemies==0):
		show();


func _on_enemy_lost_enemy():
	print("enemy dead")
	number_of_enemies-=1 # Replace with function body.
