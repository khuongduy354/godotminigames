extends Node2D
const SPEED :float = 1000.0
var velocity = Vector2.ZERO
var direction := Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	look_at(position + direction)
	
func _physics_process(delta:float):
	position += direction * SPEED *delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
