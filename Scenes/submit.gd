extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.find_child("Timer", true, false).get_time_left() > 0:
			body.find_child("Timer", true, false).paused = true
			await get_tree().process_frame
			body.find_child("RichTextLabel2", true, false).text = "You win! :)"
			if ComponentTracker.player_value > Saver.SaveFile.high_score:
				Saver.SaveFile.high_score = ComponentTracker.player_value
				Saver._save()
