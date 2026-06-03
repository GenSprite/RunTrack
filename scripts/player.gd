extends CharacterBody2D

# --- Lane system ---
var lanes = [-100.0, 0.0, 100.0]
var lane_index = 1  # start in center lane

# --- Movement ---
var base_speed = 200.0
var sprint_speed = 350.0
var current_speed = 200.0

func _ready():
	# optional safety reset
	position = Vector2(0, 0)

func _physics_process(delta):
	handle_input()
	handle_movement(delta)
	move_and_slide()


func handle_input():
	# Lane switching
	if Input.is_action_just_pressed("ui_left"):
		lane_index = max(lane_index - 1, 0)

	if Input.is_action_just_pressed("ui_right"):
		lane_index = min(lane_index + 1, 2)

	# Sprint system
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = base_speed


func handle_movement(delta):
	# Forward movement (runner feel)
	velocity = Vector2(0, current_speed)

	# Smooth lane movement (X axis)
	position.x = lerp(position.x, lanes[lane_index], 0.2)
	
var slowed = false
var slow_timer = 0.0
