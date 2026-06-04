extends Control

@onready var start_button = $StartButton

func _ready():
	# Reset time scale just in case a previous game over left it frozen at 0.0
	Engine.time_scale = 1.0
	
	# Connect the button click to our custom function below
	if start_button:
		start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	# Swaps out the main menu scene and loads up your arcade gameplay!
	get_tree().change_scene_to_file("res://scenes/main.tscn")
