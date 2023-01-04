extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String,FILE,"*.tscn") var scene_path = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_entered(body):
	if not body is Player: 
		return 
	if scene_path.empty(): 
		return
	get_tree().change_scene(scene_path)
