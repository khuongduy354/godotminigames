
tool
class_name Cursor
extends Node2D

# Emitted when clicking on hovered cell or pressing "ui_accept".
signal accept_pressed(cell)
# Emitted when the cursor moved to a new cell.
signal moved(new_cell)

export var grid: Resource = preload("res://grid.tres")
# Time before the cursor can move again in seconds.
export var ui_cooldown := 0.1
# current hover cell
var cell := Vector2.ZERO setget set_cell

# We use the timer to have a cooldown on the cursor movement.
onready var _timer: Timer = $Timer


func _ready() -> void:
	_timer.wait_time = ui_cooldown
	position = grid.calculate_map_position(cell)

# HANDLING mouse, click
func _unhandled_input(event: InputEvent) -> void:
	# mouse 
	if event is InputEventMouseMotion:
		self.cell = grid.calculate_grid_coordinates(event.position)
	# press 
	elif event.is_action_pressed("click") or event.is_action_pressed("ui_accept"):
		emit_signal("accept_pressed", cell)
		get_tree().set_input_as_handled()
		

	# arrow keys handling
	var should_move := event.is_pressed()
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()

	if not should_move:
		return

	if event.is_action("ui_right"):
		self.cell += Vector2.RIGHT
	elif event.is_action("ui_up"):
		self.cell += Vector2.UP
	elif event.is_action("ui_left"):
		self.cell += Vector2.LEFT
	elif event.is_action("ui_down"):
		self.cell += Vector2.DOWN


# draw cell on hover 
func _draw() -> void:
	draw_rect(Rect2(-grid.cell_size / 2, grid.cell_size), Color.aliceblue, false, 2.0)


func set_cell(value: Vector2) -> void:
	# We first clamp the cell coordinates and ensure that we weren't trying to move outside the
	# grid's boundaries.
	var new_cell: Vector2 = grid.clamp(value)
	if new_cell.is_equal_approx(cell):
		return

	cell = new_cell
	# If we move to a new cell, we update the cursor's position, emit a signal, and start the
	# cooldown timer that will limit the rate at which the cursor moves when we keep the direction
	# key down.
	position = grid.calculate_map_position(cell)
	emit_signal("moved", cell)
	_timer.start()
