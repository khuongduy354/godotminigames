extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Active = false 
onready var SpawnPoint = $SpawnPoint
onready var timer = $Timer
var Enemy = load("res://Enemy.tscn")

onready var SpawnTimer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time=1
	$Scoring.hide()
	$Label2.hide()
	$Dinosaur/AnimationPlayer.play("RESET")
	
func _physics_process(delta):
	$ParallaxBackground/ParallaxLayer.position.x-=1
	if not Active and Input.is_action_pressed("ui_accept"):
		start_game()
	
func end_game():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies: 
		enemy.queue_free()
	Active = false
	$Label.show()
	$Label2.show()
	$Label.text="Press space to restart."
	SpawnTimer.disconnect("timeout",self,"spawn_enemies")
	$Scoring.hide()
func start_game():
	$Scoring.show()
	Active = true
	$Dinosaur.isDead=false
	$Dinosaur/Hurt.hide()
	$Label.hide()
	$Label2.hide()
	SpawnTimer.connect("timeout",self,"spawn_enemies")
	$Dinosaur.connect("player_hit",self,"end_game")
	$Dinosaur/AnimationPlayer.play("walk")
	
func scored(): 	
	var score = int($Scoring.text) 
	score+=1 
	$Scoring.text= str(score)
	
	
func spawn_enemies():
	SpawnTimer.wait_time=rand_range(2,5)
	var enemy = Enemy.instance()
	enemy.position = SpawnPoint.position
	enemy.connect("scored",self,"scored")
	add_child(enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
