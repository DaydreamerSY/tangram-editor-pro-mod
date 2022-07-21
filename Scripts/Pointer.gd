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
	

func set_pointer(mouse_pos):
	clear ()
#	var used_tile = get_used_cells()
#	for tile_pos in used_tile:
#		set_cell(tile_pos[0], tile_pos[1], -1)
	
	var tile_pos = convert_to_cell_pos(mouse_pos)
	set_cell(tile_pos[0], tile_pos[1], 0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
