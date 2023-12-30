extends Area2D
var levelComplete=false;
var number_of_enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_enemies = get_tree().get_nodes_in_group("Enemy").size()
	Global.enemies = get_tree().get_nodes_in_group("Enemy").size()
	print(Global.enemies)
	$CollisionShape2D.set_deferred("disabled", true)
	hide(); #Hide the door


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Global.enemies)
	if(number_of_enemies==0 || Global.enemies == 0):
		$CollisionShape2D.set_deferred("disabled", false)
		show();


func _on_enemy_lost_enemy():
	number_of_enemies-=1 # Replace with function body.


func _on_boss_1_lost_enemy():
	number_of_enemies-=1
