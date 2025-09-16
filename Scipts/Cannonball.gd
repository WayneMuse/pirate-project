# Cannonball.gd
extends RigidBody2D

@export var speed := 600.0
@export var lifetime := 3.0

func _ready():
	# Auto-destroy after a few seconds
	await get_tree().create_timer(lifetime).timeout
	queue_free()
