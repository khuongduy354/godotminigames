extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal scored
onready var animation_player=$AnimationPlayer
onready var PointArea = $Point 
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("attack")	
	PointArea.connect("body_entered",self,"scored")
	$VisibilityNotifier2D.connect("screen_exited",self,"queue_free")
func scored(body:PhysicsBody2D): 
	print(body.name)
	if body.name == "Dinosaur":
		emit_signal("scored")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	position.x -=1

