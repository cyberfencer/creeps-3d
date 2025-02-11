extends Node

@export var mob_scene: PackedScene


func _ready():
	$UserInterface/Retry.hide()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()


func _on_mob_timer_timeout():
	# creates a new instance of the mob scene
	var mob = mob_scene.instantiate()

	# choose a random location on the spawn path
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# communicates the spawn location and the player's location to the mob
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

# spawn mob
	add_child(mob)
	
	mob.squashed.connect($UserInterface/ScoreLabel._on_Mob_squashed)


func _on_player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
