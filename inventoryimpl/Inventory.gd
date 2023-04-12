extends GridContainer
@export var item_data:Resource 
var holding_item:Item = null 
var BagClass = preload("res://Bag.tscn")
func _ready():
	$GridContainer.get_child(0).create_and_place("Iron Sword")
	$GridContainer.get_child(1).create_and_place("Blue Jeans")
	$GridContainer.get_child(2).create_and_place("Blue Jeans")
	
	var bag = BagClass.instantiate()
	plug_bag(bag)
	
	for inv_slot in $GridContainer.get_children():
		inv_slot.connect("gui_input",Callable(self,"slot_gui_input").bind(inv_slot))
		
func plug_bag(bag): 
	$GridContainer.add_sibling(bag)
	# connect event handlers to path 

func slot_gui_input(event,inv_slot:Slot): 
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if holding_item: 
				# place item
				if not inv_slot.item: 
					remove_child(holding_item)
					inv_slot.place_item(holding_item)
					holding_item=null
				# swap item
				else: 
					swap_item(inv_slot)
					
			# pick item
			elif inv_slot.item:
				holding_item = inv_slot.item
				inv_slot.remove_item_from_slot()
				holding_item.global_position=get_global_mouse_position()
				add_child(holding_item)
#		if shift_click: 
#			$EquipmentSlots.to_equipment_slots()
			


func swap_item(inv_slot:Slot): 
	# stack 
	if inv_slot.item.item_name == holding_item.item_name: 
		inv_slot.stack_item()
		remove_child(holding_item)
		holding_item = null
		return 
	
	remove_child(holding_item)
	var temp_item = inv_slot.item
	
	# item from hold -> slot
	inv_slot.remove_item_from_slot()
	inv_slot.place_item(holding_item)
	
	# item from  slot -> hold 
	holding_item = temp_item
	holding_item.global_position = get_global_mouse_position()
	add_child(holding_item)

			
func _input(e):
	if holding_item: 
		holding_item.global_position = get_global_mouse_position()
		pass
			
