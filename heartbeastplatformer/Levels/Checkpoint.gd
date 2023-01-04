extends Area2D

signal body_checkpointed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const fountain_off = preload("res://tileset/3 Objects/Fountain/1.png")
const fountain_on = preload("res://tileset/3 Objects/Fountain/2.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Checkpoint_body_entered(body):
	if body.is_in_group("checkpointer"): 
		$Sprite.texture = fountain_on
		emit_signal("body_checkpointed")
