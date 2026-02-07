extends Control

var component = preload("res://Scenes/cauld_component.tscn")
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_root().find_child("Player", true, false)
	create_components()
	

func create_components():
	for i in $Control/Control2.get_children():
		i.queue_free()
	for i in ComponentTracker.component_stack:
		var instance = component.instantiate()
		instance.texture = load(i.sprite)
		instance.position.y = $Control/Control2.position.y + 66 + randi_range(0,148)
		instance.position.x = $Control/Control2.position.x + 65 + randi_range(0, 80)
		prints(str($Control/Control2.position))
		$Control/Control2.add_child.call_deferred(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
