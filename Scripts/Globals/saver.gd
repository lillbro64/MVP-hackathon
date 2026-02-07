extends Node

const save_location = "user://MVPsave.tres"
var SaveFile: SaveData = SaveData.new()


func _ready() -> void:
	_load()

func _save():
	ResourceSaver.save(SaveFile, save_location)
	
func _load():
	if FileAccess.file_exists(save_location):
		SaveFile = ResourceLoader.load(save_location).duplicate(true)
		_save()
		
func _clear_save_data():
	SaveFile = SaveData.new()
	_save()
