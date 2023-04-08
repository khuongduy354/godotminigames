extends Area2D
signal collected


func _ready():
	pass # Replace with function body.



func _on_Coin_body_entered(body):
	if body is Player: 
		emit_signal("collected")
		queue_free()
