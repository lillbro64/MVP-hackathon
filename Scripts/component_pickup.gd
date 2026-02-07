extends Area2D

@export var component_data: Component
var sprite
var player_carry = false
var player_node
var in_stack
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Sprite2D
	if component_data.sprite != "":
		sprite.texture = load(component_data.sprite)
	player_node = get_tree().get_root().find_child("Player", true, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_carry:
		self.global_position = (player_node.global_position - Vector2(0,16 + (8 * (in_stack - 1))))


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if ComponentTracker.component_total < ComponentTracker.component_max:
			ComponentTracker.component_stack.append(component_data)
			ComponentTracker.component_total += 1
			in_stack = ComponentTracker.component_total
			player_carry = true
