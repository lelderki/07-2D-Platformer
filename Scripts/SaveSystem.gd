extends Node2D

var DisplayValue = 0

var save_path = "res://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func _ready():
	pass 

func SavePressed():
	get_node("/root/SaveSystem").saveValue("Values", "ValueOne")

func LoadPressed():
	get_node("/root/SaveSystem").loadValue("Values", "ValueOne")
