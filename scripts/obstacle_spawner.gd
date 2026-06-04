extends Node2D

@export var obstacle_scene: PackedScene
@export var puddle_scene: PackedScene
@export var coin_scene: PackedScene 

# Difficulty Knobs to twist in the Inspector
@export var base_spawn_interval: float = 1.4      # Start by spawning an item every 1.4 seconds
@export var minimum_spawn_interval: float = 0.4   # The absolute fastest limit (bullet-hell speed!)

var lanes = [-100.0, 0.0, 100.0]
@onready var player = get_parent().get_node_or_null("Player")

func _ready():
	if $Timer:
		$Timer.wait_time = base_spawn_interval
		$Timer.start()

func _process(_delta):
	# DYNAMIC DIFFICULTY SYSTEM:
	# As the player accelerates (or uses a boost pad), decrease the time between spawns!
	if player and $Timer:
		# Calculate a speed ratio (e.g., 300 speed = 1.0, 600 speed = 2.0)
		var speed_factor = player.current_speed / 300.0
		
		# Shrink the interval down based on how fast they are zooming
		var target_wait_time = base_spawn_interval / speed_factor
		
		# Clamp ensures it never gets mechanically impossible (lower than 0.4s)
		$Timer.wait_time = clamp(target_wait_time, minimum_spawn_interval, base_spawn_interval)

func spawn_hazard():
	var spawn_chance = randf()
	var scene_to_spawn : PackedScene = null

	# Adjusted Percentages: 60% Obstacle, 15% Boost Pad, 25% Coin
	if spawn_chance < 0.6:       
		scene_to_spawn = obstacle_scene  
	elif spawn_chance < 0.75:
		scene_to_spawn = puddle_scene    
	else:
		scene_to_spawn = coin_scene      
		
	if not scene_to_spawn:
		return

	var hazard = scene_to_spawn.instantiate()
	var lane = lanes[randi() % lanes.size()]
	hazard.position = Vector2(lane, -400)

	get_parent().add_child(hazard)

func _on_timer_timeout():
	spawn_hazard()
