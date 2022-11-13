extends RigidBody2D
var max_speed = 10
var min_speed = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta): 
	var player = get_parent().get_node("Player")
	var dest = (player.position - position)/50
	var mag = dest.length()
	if mag > max_speed: 
		dest = dest / mag * max_speed
	if mag < min_speed: 
		dest = dest / mag * min_speed
	position += dest
	look_at(player.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
