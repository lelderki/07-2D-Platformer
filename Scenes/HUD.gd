extends Node2D

func _ready():
	pass


func _on_Player_health_changed():
	var h = get_node("/root/World/Player").health
	$Health.text = "health: " + str(h)
