extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var primary_pos = Vector2(-1,-1)
var secondary_pos = Vector2(-1,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func convert_to_cell_pos(mouse_pos):
	var tile_pos = (world_to_map(mouse_pos))
	return tile_pos
	

func set_primary(mouse_pos):
	primary_pos = mouse_pos
	clear ()
	var pri_pos = convert_to_cell_pos(primary_pos)
	var sec_pos = convert_to_cell_pos(secondary_pos)
	set_cell(pri_pos[0], pri_pos[1], 0)
	set_cell(sec_pos[0], sec_pos[1], 1)
	
	
func set_secondary(mouse_pos):
	secondary_pos = mouse_pos
	clear ()
	var pri_pos = convert_to_cell_pos(primary_pos)
	var sec_pos = convert_to_cell_pos(secondary_pos)
	set_cell(pri_pos[0], pri_pos[1], 0)
	set_cell(sec_pos[0], sec_pos[1], 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
