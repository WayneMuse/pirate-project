# File: PlayerShip.gd
extends CharacterBody2D

@export var speed := 200.0
@export var turn_speed := 2.5  # Radians per second

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		rotation -= turn_speed * delta
	elif Input.is_action_pressed("ui_right"):
		rotation += turn_speed * delta

	move_and_slide()
