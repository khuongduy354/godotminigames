extends Area2D
class_name Obstacle

# use obstacles at the end of water to detect player
signal drown
signal player_hit
export var is_water = false

func _ready(): 
	pass 
	
func _on_Obstacle_body_entered(body):
	if body is Player: 
		if is_water:
			emit_signal("drown")
			return
		emit_signal("player_hit")
	
