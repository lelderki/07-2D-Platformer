extends Node2D

func _ready():
	pass


func _on_Player_health_changed():
	var h = get_node("/root/SaveSystem").health
	$Health.text = "Health: " + str(h)


func _on_Save_pressed():
	get_node("/root/SaveSystem").save_data()


func _on_Load_pressed():
	get_node("/root/SaveSystem").load_data()
