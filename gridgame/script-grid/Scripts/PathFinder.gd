# Finds the path between two points among walkable cells using the AStar pathfinding algorithm.
class_name PathFinder
extends Reference

# We will use that constant in "for" loops later. It defines the directions in which we allow a unit
# to move in the game: up, left, right, down.
const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

var _grid: Resource
# This variable holds an AStar2D instance that will do the actual pathfinding. Our script is mostly
# here to initialize that object.
var _astar := AStar2D.new()


# Initializes the Astar2D object upon creation.
func _init(grid: Grid, walkable_cells: Array) -> void:
	# Because we will instantiate the `PathFinder` from our UnitPath's script, we pass it the data it
	# needs to initialize itself via its constructor function, _init().
	_grid = grid
	# To create our AStar graph, we will need the index value corresponding to each grid cell. Here,
	# we cache a mapping between cell coordinates and their unique index. Doing so here slightly
	# simplifies the code and improves performance a bit.
	var cell_mappings := {}
	for cell in walkable_cells:
		# For each cell, we define a key-value pair of cell coordinates: index.
		cell_mappings[cell] = _grid.as_index(cell)
	# We then add all the cells to our AStar2D instance and connect them to create our pathfinding
	# graph.
	_add_and_connect_points(cell_mappings)


# Returns the path found between `start` and `end` as an array of Vector2 coordinates.
func calculate_point_path(start: Vector2, end: Vector2) -> PoolVector2Array:
	# With the AStar algorithm, we have to use the points' indices to get a path. This is why we
	# need a reliable way to calculate an index given some input coordinates.
	# Our Grid.as_index() method does just that.
	var start_index: int = _grid.as_index(start)
	var end_index: int = _grid.as_index(end)
	# We just ensure that the AStar graph has both points defined. If not, we return an empty
	# PoolVector2Array() to avoid errors.
	if _astar.has_point(start_index) and _astar.has_point(end_index):
		# The AStar2D object then finds the best path between the two indices.
		return _astar.get_point_path(start_index, end_index)
	else:
		return PoolVector2Array()


# Adds and connects the walkable cells to the Astar2D object.
func _add_and_connect_points(cell_mappings: Dictionary) -> void:
	# This function works with two loops. First, we register all our points in the AStar graph.
	# We pass each cell's unique index and the corresponding Vector2 coordinates to the
	# AStar2D.add_point() function.
	for point in cell_mappings:
		_astar.add_point(cell_mappings[point], point)

	# Then, we loop over the points again, and we connect them with all their neighbors. We use
	# another function to find the neighbors given a cell's coordinates.
	for point in cell_mappings:
		for neighbor_index in _find_neighbor_indices(point, cell_mappings):
			# The AStar2D.connect_points() function connects two points on the graph by index, *not*
			# by coordinates.
			_astar.connect_points(cell_mappings[point], neighbor_index)


# Returns an array of the `cell`'s connectable neighbors.
func _find_neighbor_indices(cell: Vector2, cell_mappings: Dictionary) -> Array:
	var out := []
	# To find the neighbors, we try to move one cell in every possible direction and is ensure that
	# this cell is walkable and not already connected.
	for direction in DIRECTIONS:
		var neighbor: Vector2 = cell + direction
		# This line ensures that the neighboring cell is part of our walkable cells.
		if not cell_mappings.has(neighbor):
			continue
		# Because we call the function for every cell, we will get neighbors that are already
		# connected. If you don't don't check for existing connections, you'll get many errors.
		if not _astar.are_points_connected(cell_mappings[cell], cell_mappings[neighbor]):
			out.push_back(cell_mappings[neighbor])
	return out
