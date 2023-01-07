extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var BushDeathEffect =preload("res://World/BushDeathEffect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func receive_hit(damage): 
	var bush_death_effect = BushDeathEffect.instance()
	bush_death_effect.global_position = global_position 
	get_tree().root.add_child(bush_death_effect)
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
