extends Control

var component = preload("res://Scenes/cauld_component.tscn")
var player
var component_storage: Array[Component]
var comp_nodes: Array[Node]
var potion_num: int
var potion_boxes: int = 0
var info_holder
var info_box = preload("res://Scenes/potion_info_container.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info_holder = $Control/ColorRect/VBoxContainer
	player = get_tree().get_root().find_child("Player", true, false)
	create_components()
	potion_num = ComponentTracker.potion_inventory.size()
	
	
	

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
	if potion_num != ComponentTracker.potion_inventory.size():
		update_potion_info()

func update_potion_info():
	for i in info_holder.get_children():
		i.queue_free()
	for i in ComponentTracker.potion_inventory:
		var instance = info_box.instantiate()
		instance.potion = i
		instance.get_node("TextureRect").texture = load(i.sprite)
		#instance.TextureRect.texture = load(i.sprite)
		instance.get_node("TextureRect/Control/NameLabel").text = i.name
		#instance.TextureRect.Control.NameLabel.text = i.name
		$Control/ColorRect/VBoxContainer.add_child.call_deferred(instance)

func _on_button_pressed() -> void:
	if !component_storage.is_empty():
		PotionBrewer.calculate_brew(component_storage)
		prints(str(component_storage))
		for i in comp_nodes:
			i.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("c-components"):
		component_storage.append(body.comp_data)
		comp_nodes.append(body)



func _on_component_checker_body_exited(body: Node2D) -> void:
	if body.is_in_group("c-components"):
		component_storage.remove_at(component_storage.find(body.comp_data))
		comp_nodes.remove_at(comp_nodes.find(body))
