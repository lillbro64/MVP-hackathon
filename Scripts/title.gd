extends Node2D

const gameplay = preload("res://Scenes/gameplay.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$RichTextLabel2.text = "High Score: " + str(Saver.SaveFile.high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(gameplay)


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
