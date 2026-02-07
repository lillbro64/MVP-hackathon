extends Node2D

const gameplay = preload("res://Scenes/gameplay.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$RichTextLabel2.text = "High Score: " + str(Saver.SaveFile.high_score)
	ComponentTracker.component_max = 5
	ComponentTracker.component_total = 0
	ComponentTracker.component_stack.resize(0)
	ComponentTracker.stack_changed = false

	ComponentTracker.potion_inventory.resize(0)

	ComponentTracker.player_value = 0
	ComponentTracker.player_max_health = 100
	ComponentTracker.player_health = 100
	ComponentTracker.player_stam_max = 100
	ComponentTracker.player_speed_mod = 2
	ComponentTracker.player_strength = 0

	ComponentTracker.has_won = false
	ComponentTracker.has_lost = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(gameplay)


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
