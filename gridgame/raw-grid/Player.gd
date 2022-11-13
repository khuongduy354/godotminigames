extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move_input = {
	"ui_right":Vector2.RIGHT,
	"ui_left":Vector2.LEFT,
	"ui_down":Vector2.DOWN,
	"ui_up":Vector2.UP,	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	for dir in move_input.keys(): 
		if event.is_action_pressed(dir):
			move(dir)

func move(dir): 
	var move_vec = move_input[dir] * 16
	$RayCast2D.cast_to = move_vec 
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding(): 
		position += move_vec
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
