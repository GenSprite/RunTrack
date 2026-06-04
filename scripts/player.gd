extends CharacterBody2D

# --- Lane system ---
var lanes = [-100.0, 0.0, 100.0]
var lane_index = 1  # start in center lane

# --- Movement & Progression ---
var base_speed = 300.0
var sprint_speed = 500.0
var boost_speed = 700.0       
var current_speed = 300.0

@export var acceleration_rate: float = 4.0

# --- Boost Status Variables ---
var boosted = false
var boost_timer = 0.0

# FIX 1: Ensure this variable is explicitly declared at the top of your script!
@onready var animation_player = $Sprite2D

func _ready():
	position = Vector2(0, 0)

func _physics_process(delta):
	base_speed += acceleration_rate * delta
	sprint_speed = base_speed * 1.6
	boost_speed = base_speed * 2.2 

	handle_input()
	handle_boost_timer(delta) 
	handle_movement(delta)
	update_animations()
	move_and_slide()


func handle_input():
	if Input.is_action_just_pressed("ui_left"):
		lane_index = max(lane_index - 1, 0)

	if Input.is_action_just_pressed("ui_right"):
		lane_index = min(lane_index + 1, 2)

	if boosted:
		current_speed = boost_speed 
	elif Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = base_speed


func handle_movement(delta):
	velocity = Vector2(0, 0) 
	position.x = lerp(position.x, lanes[lane_index], 0.2)


func update_animations():
	# Safety check: if the AnimatedSprite2D node is missing, exit early without crashing
	if animation_player == null:
		return
		
	# FIX 2: Using correct Godot 4 syntax (.sprite_frames.has_animation)
	if boosted:
		if animation_player.sprite_frames.has_animation("sprinting"):
			animation_player.play("sprinting")
	elif Input.is_action_pressed("sprint"):
		if animation_player.sprite_frames.has_animation("sprinting"):
			animation_player.play("sprinting")
	else:
		if animation_player.sprite_frames.has_animation("flying"):
			animation_player.play("flying")


func handle_boost_timer(delta):
	if boosted:
		boost_timer -= delta
		if boost_timer <= 0.0:
			boosted = false


func apply_boost_effect(duration: float):
	boosted = true
	boost_timer = duration
	print("WARP DRIVE ENGAGED!")
