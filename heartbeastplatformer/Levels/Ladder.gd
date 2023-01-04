extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_climbzone_body_entered(body:PhysicsBody2D):
	if body ==null: 
		return
	if body.is_in_group("climber"):	
		if body.has_method("set_in_ladder"):
			body.set_in_ladder(true)


func _on_climbzone_body_exited(body:PhysicsBody2D):
	if body==null: 
		return
	if body.is_in_group("climber"):	
		if body.has_method("set_in_ladder"):
			body.set_in_ladder(false)
