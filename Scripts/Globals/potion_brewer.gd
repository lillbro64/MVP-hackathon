extends Node

var potion_value: int
var potion_effect: float
var f_effect: String
var effects: Array[String]
var spec_effect: String

var total_potion_count: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func brew_potion():
	total_potion_count += 1
	var potion = Potion.new()
	potion.effect = f_effect
	potion.value = potion_value
	potion.name = "BrewedPotion" + str(total_potion_count)
	if f_effect == "HEAL":
		potion.sprite = "res://Sprites/Potions/Health Potion.png"
	elif f_effect == "ST-UP":
		potion.sprite = "res://Sprites/Potions/Stamina Potion.png"
	elif f_effect == "SP-UP":
		potion.sprite = "res://Sprites/Potions/Speed Potion.png"
	elif f_effect == "H-UP":
		potion.sprite = "res://Sprites/Potions/Medicine Potion.png"
	if spec_effect == "":
		match randi_range(1, 5):
			1:
				potion.sprite = "res://Sprites/Potions/Health Potion.png"
			2:
				potion.sprite = "res://Sprites/Potions/Mana Potion.png"
			3:
				potion.sprite = "res://Sprites/Potions/Stamina Potion.png"
			4:
				potion.sprite = "res://Sprites/Potions/Mundane Potion.png"
			5:
				potion.sprite = "res://Sprites/Potions/Medicine Potion.png"
	ComponentTracker.potion_inventory.append(potion)

func effect_handling():
	var effect_weight = 0
	if potion_effect < 1:
		@warning_ignore("integer_division")
		potion_value = potion_value / 2
	elif potion_effect < 2:
		pass
	elif potion_effect < 3:
		@warning_ignore("narrowing_conversion")
		potion_value = potion_value * 1.2
		
	if !effects.is_empty():
		for i in effects:
			match i:
				"health":
					if effect_weight < 1:
						effect_weight = 1
						f_effect = "HEAL"
				"nullify":
					if effect_weight < 4:
						effect_weight = 4
						f_effect = ""
				"st-up":
					if effect_weight < 5:
						effect_weight = 5
						f_effect = "ST-UP"
				"h-up":
					if effect_weight < 3:
						effect_weight = 3
						f_effect = "H-UP"
				"sp-up":
					if effect_weight < 2:
						effect_weight = 2
						f_effect = "SP-UP"
						
	brew_potion()

func calculate_brew(components: Array[Component]):
	for i in components:
		potion_value += i.value
		potion_effect += i.potion_impact
		if i.special_impact != "":
			effects.append(i.special_impact)
		ComponentTracker.component_stack.remove_at(ComponentTracker.component_stack.find(i))
	effect_handling()
