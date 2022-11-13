extends Node2D
signal scored
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("pipes")
	connect("scored",get_parent(),"_on_Pipes_scored")


func _physics_process(delta):
	position+=Vector2(-2,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func _on_Area2D_body_entered(body):
	emit_signal("scored") # Replace with function body.



