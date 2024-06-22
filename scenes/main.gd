extends Node

var stump = preload("res://scenes/stump.tscn")
var bird = preload("res://scenes/bird.tscn")
var rock = preload("res://scenes/rock.tscn")
var obstacle_types :=[stump,bird,rock]

const START_POS := Vector2i(150,485)
const CAM_START_POS := Vector2i(823,593)
var score : int
const SCORE_MOD : int = 10
var speed : float
const START_SPEED : float = 10.0
const MAX_SPEED : int = 25
const SPEED_MOD : int = 5000
var screen_size : Vector2i
var game_running : bool

func _ready():
	screen_size = get_window().size
	new_game()
	
func new_game():
	score = 0
	show_score()
	game_running = false
	$Player.position = START_POS
	$Player.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0,390)
	$HUD.get_node("Startlabel").show()
	
	
func _process(delta):
	if game_running:
		speed = START_SPEED + score / SPEED_MOD
		if speed>MAX_SPEED:
			speed = MAX_SPEED
		$Player.position.x +=speed
		$Camera2D.position.x +=speed
		score +=speed
		show_score()
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 2:
			$Ground.position.x +=screen_size.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("Startlabel").hide()
func show_score():
	$HUD.get_node("Scorelabel").text = "SCORE: "+ str(score / SCORE_MOD)
	
