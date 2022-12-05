extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum GameStateEnum{
	START,RESTART,ACTIVE
}
var GameState=GameStateEnum.START

onready var SpawnPoint = $SpawnPoint
onready var timer = $Timer
onready var SpawnTimer = $SpawnTimer

onready var ScoringLabel = $CanvasLayer/Scoring
onready var GameOverLabel = $CanvasLayer/Label2
onready var GuideLabel = $CanvasLayer/Label

var Enemy = load("res://Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time=1
	update_hud()
	$Dinosaur/AnimationPlayer.play("RESET")
	
func _physics_process(delta):
	if GameState!=GameStateEnum.ACTIVE and Input.is_action_pressed("ui_accept"):
		start_game()

func update_hud():
	match GameState:
		GameStateEnum.START:
			ScoringLabel.show()
			GameOverLabel.hide()
		GameStateEnum.RESTART: 
			GuideLabel.text="Press space to restart."
			GuideLabel.show()
			GameOverLabel.show()
			ScoringLabel.hide() 
		GameStateEnum.ACTIVE: 
			GameOverLabel.hide()
			GuideLabel.hide()

func end_game():
	GameState=GameStateEnum.RESTART
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies: 
		enemy.queue_free()
	
	update_hud()

func start_game():
	GameState=GameStateEnum.ACTIVE
	$Dinosaur.isDead=false
	$Dinosaur/Hurt.hide()

	SpawnTimer.connect("timeout",self,"spawn_enemies")
	$Dinosaur.connect("player_hit",self,"end_game")
	$Dinosaur/AnimationPlayer.play("walk")
	
	update_hud()
	
func scored(): 	
	var score = int(ScoringLabel.text) 
	score+=1 
	ScoringLabel.text= str(score)
	
	
func spawn_enemies():
	SpawnTimer.wait_time=rand_range(2,5)
	var enemy = Enemy.instance()
	enemy.position = SpawnPoint.position
	enemy.connect("scored",self,"scored")
	add_child(enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
