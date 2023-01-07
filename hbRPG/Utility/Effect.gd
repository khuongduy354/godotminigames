extends AnimatedSprite



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	play("Animate")
	self.connect("animation_finished",self,"_on_anim_finished")
func _on_anim_finished(): 
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
