extends CharacterBody2D

var player_sprite
var s_bar
var s_timer
var cauldron

var can_move = true
var dir
var moving = false
var movement_vector: Vector2
var p_stam = 100
var s_cooldown = false
var s_regen = false
@export var p_speed = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_sprite = $AnimatedSprite2D
	s_bar = $AnimatedSprite2D/Camera2D/UIHandler/ColorRect/ColorRect2
	s_timer = $AnimatedSprite2D/Camera2D/UIHandler/StamTimer
	cauldron = load("res://Scenes/cauldron_ui.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if !can_move:
		if Input.is_action_just_pressed("space"):
			$AnimatedSprite2D/Camera2D/UIHandler/CauldronUI.visible = false
			can_move = true
	else:
		if Input.is_action_just_pressed("space"):
			$AnimatedSprite2D/Camera2D/UIHandler/CauldronUI.global_position = self.global_position
			$AnimatedSprite2D/Camera2D/UIHandler/CauldronUI.visible = true
			$AnimatedSprite2D/Camera2D/UIHandler/CauldronUI.create_components()
			can_move = false
		if Input.is_action_pressed("run"):
			if !s_cooldown:
				s_regen = false
				s_timer.start(2)
				p_speed = 1 * ComponentTracker.player_speed_mod
				p_stam -= 1
				s_bar.size.x = p_stam
				if p_stam <= 0:
					p_stam = 0
					s_cooldown = true
					s_bar.color = Color(255, 0, 0)
					p_speed = 1
		else:
			p_speed = 1
		if Input.is_action_pressed("left"):
			movement_vector.x -= 1
			dir = "left"
			moving = true
		elif Input.is_action_pressed("right"):
			movement_vector.x += 1
			dir = "right"
			moving = true
		if Input.is_action_pressed("up"):
			movement_vector.y -= 1
			dir = "up"
			moving = true
		elif Input.is_action_pressed("down"):
			movement_vector.y += 1
			dir = "down"
			moving = true
		
		player_sprite.set_speed_scale(p_speed)
		
		match dir:
			"up":
				if moving:
					player_sprite.play("walk_up")
				else:
					player_sprite.set_animation("default")
					player_sprite.pause()
					player_sprite.set_frame(1)
			"down":
				if moving:
					player_sprite.play("walk_down")
				else:
					player_sprite.set_animation("default")
					player_sprite.pause()
					player_sprite.set_frame(0)
			"left":
				if moving:
					player_sprite.play("walk_left")
				else:
					player_sprite.set_animation("default")
					player_sprite.pause()
					player_sprite.set_frame(2)
			"right":
				if moving:
					player_sprite.play("walk_right")
				else:
					player_sprite.set_animation("default")
					player_sprite.pause()
					player_sprite.set_frame(3)
			
		movement_vector = movement_vector * p_speed
		global_position += movement_vector
		move_and_slide()
		
		for i in get_slide_collision_count():
			var coll = get_slide_collision(i)
			if coll.get_collider() is RigidBody2D:
				coll.get_collider().apply_central_impulse(-coll.get_normal() * (p_speed * 2))
	
	if moving:
		moving = false
	movement_vector = Vector2(0,0)
	velocity = Vector2(0,0)
	
	if s_cooldown:
		p_stam += 0.25
		if step_decimals(p_stam) == 0:
			s_bar.size.x = p_stam
		if p_stam >= ComponentTracker.player_stam_max:
			p_stam = ComponentTracker.player_stam_max
			s_cooldown = false
			s_bar.color = Color(0.0, 1.0, 0.38, 1.0)
			
		
	elif s_regen:
		p_stam += 0.5
		if step_decimals(p_stam) == 0:
			s_bar.size.x = p_stam
		if p_stam >= ComponentTracker.player_stam_max:
			p_stam = ComponentTracker.player_stam_max
			s_regen = false
				


func _on_stam_timer_timeout() -> void:
	s_timer.stop()
	if !s_cooldown:
		s_regen = true
