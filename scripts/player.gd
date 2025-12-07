extends CharacterBody3D
##
## Simple left/right character controller
##

## Speed of character movement
const SPEED = 5.0
const GRAVITY = 0
const JUMP_VELOCITY = 5

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		if Input.is_action_just_pressed("down"):
			velocity.y -= GRAVITY * _delta
		else:
			velocity.y -= GRAVITY * _delta * 2

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

		
	var input_dir := Input.get_vector("left", "right", "ui_up", "ui_down")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.x = move_toward(velocity.z, 0, SPEED)
		

	move_and_slide()
	
	#    var collision = get_last_slide_collision()
	#    if collision:
	#	print("Collided with: ", collision.get_collider())
	#	get_tree().quit()
