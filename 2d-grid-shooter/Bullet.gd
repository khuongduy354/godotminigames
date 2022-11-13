extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var v = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass









func _on_Area2D_body_entered(body):
	if "Enemy" in body.name: 
		queue_free()
	if "TileMap" in body.name:
		queue_free()
