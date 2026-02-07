extends ColorRect

const title = preload("res://Scenes/title.tscn")
var timer_started = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ComponentTracker.has_won:
		global_position = get_tree().get_root().find_child("Player", true, false).global_position
		visible = true
		$RichTextLabel.text = "SCORE: " + str(ComponentTracker.player_value) + "
HIGH SCORE: " + str(Saver.SaveFile.high_score)
		if !timer_started:
			$Timer.start(3)
			prints("the j")
			timer_started = true
	
	if ComponentTracker.has_lost:
		global_position = get_tree().get_root().find_child("Player", true, false).global_position
		visible = true
		$RichTextLabel.text = "You lose. :("
		if !timer_started:
			$Timer.start(3)
			prints("the j")
			timer_started = true


func _on_timer_timeout() -> void:
	prints("aaaaaaaaa")
	get_tree().change_scene_to_packed(load("res://Scenes/title.tscn"))
