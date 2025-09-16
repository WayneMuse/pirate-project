extends CharacterBody2D

@export var speed := 200.0
@export var turn_speed := 2.5  # Radians per second
@onready var cannonball_scene = preload("res://Scenes/cannonball.tscn")  # ✅ Update this path

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Movement
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		rotation -= turn_speed * delta
	elif Input.is_action_pressed("ui_right"):
		rotation += turn_speed * delta

	move_and_slide()

	# Firing cannons
	if Input.is_action_just_pressed("fire_port"):
		fire_cannon(-1)
	elif Input.is_action_just_pressed("fire_starboard"):
		fire_cannon(1)

func fire_cannon(side: int):
	var cannonball = cannonball_scene.instantiate() as RigidBody2D
	get_parent().add_child(cannonball)

	# Position the cannonball at the side of the ship
	var offset = Vector2(0, -20 * side).rotated(rotation + (PI / 2))
	cannonball.global_position = global_position + offset

	# Set velocity relative to ship's rotation
	var fire_direction = Vector2.RIGHT.rotated(rotation + side * PI / 2)
	cannonball.linear_velocity = fire_direction * cannonball.speed
