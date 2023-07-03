class_name Player
extends CharacterBody2D

@onready var hitbox := $HitBox
@onready var anim := $AnimationPlayer

@export var move_speed := 200.0


func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
	
	velocity = input_vector * move_speed
	
	move_and_slide()
