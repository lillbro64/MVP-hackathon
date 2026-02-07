extends HBoxContainer

@export var potion: Potion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func drink_potion():
	ComponentTracker.player_value += potion.value
	if potion.effect != "":
		match potion.effect:
			"HEAL":
				ComponentTracker.player_health = ComponentTracker.player_max_health
			"ST-UP":
				ComponentTracker.player_stam_max += 50
			"SP-UP":
				ComponentTracker.player_speed_mod += 1
			"H-UP":
				ComponentTracker.player_max_health += 25
				ComponentTracker.player_health += 25
	ComponentTracker.potion_inventory.remove_at(ComponentTracker.potion_inventory.find(potion))
	queue_free()

func _on_button_pressed() -> void:
	printerr("yay")


func _on_button_focus_entered() -> void:
	drink_potion()
