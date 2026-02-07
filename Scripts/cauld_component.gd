extends Node2D

var mouse_in = false
var holding = false
var sprite: String
@export var comp_data: Component
@export var in_stack: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite.texture = load(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") && mouse_in:
		holding = true
	if Input.is_action_pressed("click") && holding:
		self.global_position = get_global_mouse_position()
	if Input.is_action_just_released("click"):
		holding = false


func _on_area_2d_mouse_entered() -> void:
	mouse_in = true


func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
