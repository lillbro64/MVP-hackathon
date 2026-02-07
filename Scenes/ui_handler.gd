extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !$Timer.paused:
		$RichTextLabel.text = " Value: " + str(ComponentTracker.player_value)
		$RichTextLabel2.text = "Time: " + str(int($Timer.get_time_left()))
		if $Timer.get_time_left() <= 0:
			$RichTextLabel2.text = "You lose :("
			ComponentTracker.has_lost = true
	
