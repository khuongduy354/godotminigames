extends GridContainer
class_name Bagg
signal active_slot_changed

var selected_slot = 0  : set = _set_slot

func _set_slot(new_slot): 
	selected_slot = new_slot 
	emit_signal("active_slot_changed",selected_slot)
const SLOT_NUMS=4 
func _ready():
	get_child(0).create_and_place("Iron Sword")
	get_child(1).create_and_place("Blue Jeans")
	get_child(2).create_and_place("Blue Jeans")

func _input(event):
	if event.is_action_pressed("scroll_down"):
		if selected_slot == 0: 
			selected_slot = SLOT_NUMS - 1 
		else:
			selected_slot-=1
	if event.is_action_pressed("scroll_up"):
		if selected_slot == SLOT_NUMS-1: 
			selected_slot = 0 
		else:
			selected_slot+=1
		
		
