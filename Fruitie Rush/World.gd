extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func ready(): 
	pass
func _process(delta):
	$CanvasLayer/MangoCount.text = str($Player.mangos)
	$CanvasLayer/StoneCount.text = str($Player.stones)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_gameover():
	get_tree().change_scene("res://GameOver.tscn")
