extends Node2D

@export var obstacle_scene: PackedScene

var lanes = [-100.0, 0.0, 100.0]

func _ready():
	$Timer.start()

func spawn_obstacle():
	print("SPAWNING")
	var obstacle = obstacle_scene.instantiate()

	var lane = lanes[randi() % lanes.size()]

	obstacle.position = Vector2(lane, -400)

	get_parent().add_child(obstacle)

func _on_timer_timeout():
	spawn_obstacle()
