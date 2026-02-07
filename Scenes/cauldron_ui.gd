extends Control

var component = preload("res://Scenes/cauld_component.tscn")
var player
var component_storage: Array[Component]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("Player", true, false)
	create_components()
	

func create_components():
	for i in $Control/Control2.get_children():
		i.queue_free()
	for i in ComponentTracker.component_stack:
		var instance = component.instantiate()
		instance.sprite = i.sprite
		instance.comp_data = i
		instance.in_stack = ComponentTracker.component_stack.find(i)
		instance.position.y = $Control/Control2.position.y + 66 + randi_range(0,148)
		instance.position.x = $Control/Control2.position.x + 65 + randi_range(0, 80)
		$Control/Control2.add_child.call_deferred(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	prints(str(component_storage))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("c-components"):
		component_storage.append(body.comp_data)



func _on_component_checker_body_exited(body: Node2D) -> void:
	if body.is_in_group("c-components"):
		component_storage.remove_at(component_storage.find(body.comp_data))
