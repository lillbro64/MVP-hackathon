extends RigidBody2D

var chunk = preload("res://Scenes/chunk.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if absf(linear_velocity.x) >= 100 || absf(linear_velocity.y) >= 100:
		var rand_chunks = randi_range(2, 6)
		for i in rand_chunks:
			var instance = chunk.instantiate()
			instance.global_position = self.global_position
			instance.position.x += randi_range(-10, 10)
			instance.position.y += randi_range(-10, 10)
			instance.linear_velocity.x = randf_range(-20.0,20.0)
			instance.linear_velocity.y = randf_range(-20.0,20.0)
			get_tree().get_root().add_child.call_deferred(instance)
		queue_free()
