extends Node2D

var component = preload("res://Components/component.tscn")
var crate = preload("res://Scenes/crate.tscn")
var crate_count = 0
var crate_cap: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = randf_range(5, 20)
	$Timer.start()
	crate_cap = randi_range(4,8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var instance = component.instantiate()
	instance.global_position = global_position
	instance.global_position.x += randi_range(-30, 30)
	instance.global_position.y += randi_range(-30, 30)
	match randi_range(0,5):
		0:
			instance.component_data = load("res://Components/Component Resources/mushroom.tres")
		1:
			instance.component_data = load("res://Components/Component Resources/leaf.tres")
		2:
			instance.component_data = load("res://Components/Component Resources/branch.tres")
		3:
			instance.component_data = load("res://Components/Component Resources/bird.tres")
		4:
			instance.component_data = load("res://Components/Component Resources/worm.tres")
		5:
			instance.component_data = load("res://Components/Component Resources/finger.tres")
	get_tree().get_root().find_child("Gameplay", true, false).add_child.call_deferred(instance)
	
	crate_count += 1
	if crate_count >= crate_cap:
		var instance1 = crate.instantiate()
		instance1.global_position = global_position
		instance1.global_position.x += randi_range(-40, 40)
		instance1.global_position.y += randi_range(-40, 40)
		get_tree().get_root().find_child("Gameplay", true, false).add_child.call_deferred(instance1)
		crate_count = 0
