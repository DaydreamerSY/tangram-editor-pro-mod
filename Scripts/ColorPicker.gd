extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func convert_to_cell_pos(mouse_pos):
	var tile_pos = (world_to_map(mouse_pos))
	return tile_pos
	

func get_color_id(mouse_pos):
	var tile_pos = convert_to_cell_pos(mouse_pos)
	return get_cell(tile_pos[0], tile_pos[1])
	
func get_pos_color_from_number(number_key):
	var used_cell = get_used_cells()
	for cell in used_cell:
		if get_cell(cell.x, cell.y) == number_key:
			return map_to_world(cell)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
