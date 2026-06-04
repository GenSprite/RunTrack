extends Node2D

var score: float = 0.0
var coins: int = 0 
var is_game_over: bool = false

@export var score_multiplier: float = 0.02

@onready var player = $Player
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var coin_label = %CoinLabel 

@onready var game_over_panel = %GameOverPanel
@onready var final_score_label = %FinalScoreLabel
@onready var restart_button = %RestartButton

# Audio node references
@onready var coin_sound = $CoinSound
@onready var boost_sound = $BoostSound
@onready var background_music = $BackgroundMusic # References your loop music
@onready var game_over_sound = $GameOverSound   # References your crash sound

func _ready():
	score = 0.0
	coins = 0 
	is_game_over = false
	Engine.time_scale = 1.0 
	
	if game_over_panel:
		game_over_panel.visible = false
		
	if restart_button:
		restart_button.pressed.connect(_on_restart_button_pressed)

func _process(delta):
	if is_game_over:
		return
		
	if player and score_label:
		score += player.current_speed * delta * score_multiplier
		score_label.text = "Score: " + str(int(score))


func add_coin():
	coins += 1
	if coin_label:
		coin_label.text = "Coins: " + str(coins)
	
	# Play the coin collection sound effect!
	if coin_sound:
		coin_sound.play()


# Triggered by the speed pad script when run over
func play_boost_sound():
	if boost_sound:
		boost_sound.play()


func trigger_game_over():
	if is_game_over:
		return
	
	is_game_over = true
	
	# 1. AUDIO CONTROL: Kill the music, play the crash sound!
	if has_node("BackgroundMusic"):
		$BackgroundMusic.stop() # Target the node directly by its exact name!
		
	if game_over_sound:
		game_over_sound.play()
	
	# 2. UI & GAME CONTROL
	if final_score_label:
		final_score_label.text = "Final Score: " + str(int(score)) + "\nCoins: " + str(coins)
	if score_label:
		score_label.visible = false 
	if game_over_panel:
		game_over_panel.visible = true
	
	Engine.time_scale = 0.0 

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
