extends KinematicBody2D

const GRAVITY = 2
var veloc = Vector2.ZERO 


func _physics_process(delta): 
	veloc.y+= GRAVITY 
	move_and_slide(veloc)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Mango.connect("collected",self,"_on_collected")
func _on_collected(): 
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
