extends CharacterBody3D

signal squashed

@export var min_speed = 5
@export var max_speed = 25


func _physics_process(_delta):
	move_and_slide()


func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))

# spice the game up with varied speed
	var random_speed = randf_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	$AnimationPlayer.speed_scale = random_speed / min_speed


func squash():
	squashed.emit()
	queue_free()


func _on_visible_on_screen_notifier_screen_exited():
	queue_free()
