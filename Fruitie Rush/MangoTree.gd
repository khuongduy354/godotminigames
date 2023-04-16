extends Area2D

var MangoScene = preload("res://Mango.tscn")
var can_drop = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_bullet_hit(): 
	if not can_drop: 
		return
	var mango=MangoScene.instance()
	mango.position=$Position2D.position
	mango.get_node("Mango").isStone=false
	add_child(mango)
	$Mango.queue_free()
	can_drop = false

