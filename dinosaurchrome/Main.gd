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

var Enemy = preload("res://Enemy/EnemyBase.tscn")

func _ready():
	timer.wait_time=1
	update_hud()
	
func _physics_process(delta):
	if GameState!=GameStateEnum.ACTIVE and Input.is_action_pressed("enter"):
		start_game()

func update_hud():
	match GameState:
		GameStateEnum.START:
			ScoringLabel.show()
			GameOverLabel.hide()
		GameStateEnum.RESTART: 
			GuideLabel.text="Press Enter to restart."
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
	SpawnTimer.connect("timeout",self,"spawn_enemies")
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
	

