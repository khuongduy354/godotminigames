extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _timer = null
var pipes = preload("res://Scenes/Pipes.tscn")
var bird = preload("res://Scenes/Bird.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()	
	

func show_gui(doShow): 
	$CanvasLayer/TextureButton.visible = doShow  

func start_game(): 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Timer_timeout():
	var pipe = pipes.instance() 
	pipe.position.x=262
	pipe.position.y = -41 
	pipes
	add_child(pipe)

	

func _on_Pipes_scored():
	print("scored")
	$Label.text=str(int($Label.text)+1)



func _on_Bird_game_over():
	pass
	
func _on_TextureButton_pressed():
	start_game()
