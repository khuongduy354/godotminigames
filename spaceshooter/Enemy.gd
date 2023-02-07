extends KinematicBody2D

export var speed = 500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func receive_hit(hitbox:Hitbox):
	queue_free()

func _physics_process(delta): 
	position+=speed*Vector2(0,1)*delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
