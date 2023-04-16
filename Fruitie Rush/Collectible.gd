extends Area2D
signal collected
export var isStone = true
func _ready():
	self.connect("area_entered",self,"_on_area_entered")
	

func _on_area_entered(area):
	if area.is_in_group("collector"): 
		if area.owner.has_method("collect"): 
			area.owner.collect(isStone)
			if isStone: 
				queue_free()
			else: 
				emit_signal("collected")
