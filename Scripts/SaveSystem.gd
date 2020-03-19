extends Node2D

var health = 100
var level = 0

var save_path = "res://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func _ready():
	pass 

func updateHealth(h):
	health += h

func save_data():
	config.set_value("Save","health",health)
	config.set_value("Save","level",level)
	config.save(save_path)

func load_data():
	health = config.get_value("Save","health")
	level = config.get_value("Save","level")
	if level == 1:
		get_tree().change_scene("res://Scenes/World.tscn")
	if level == 2:
		get_tree().change_scene("res://Scenes/World2.tscn")
