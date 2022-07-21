extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var grid
var pointer
var color_picker

var current_pos = Vector2(0,0)
var current_id_color = -1

var ground_region = [[0,0], [10,10]]
var color_region = [[1,11], [6,13]]
var blocker_region = [[7,11], [8,12]]


# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_node("Grid")
	pointer = get_node("Pointer")
	color_picker = get_node("ColorPicker")
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("placeBlock"):
		current_pos = get_viewport().get_mouse_position()

		if check_legit_pos(grid.convert_to_cell_pos(current_pos), ground_region):
			grid.change_tile(current_pos, current_id_color)

		if check_legit_pos(pointer.convert_to_cell_pos(current_pos), color_region):
			pointer.set_pointer(current_pos)
			update_selector(color_picker.get_color_id(current_pos))

		if check_legit_pos(pointer.convert_to_cell_pos(current_pos), blocker_region):
			pointer.set_pointer(current_pos)
			update_selector(color_picker.get_color_id(current_pos))



	if Input.is_action_pressed("removeBlock"):
		current_pos = get_viewport().get_mouse_position()

		if check_legit_pos(grid.convert_to_cell_pos(current_pos), ground_region):
			grid.change_tile(current_pos, -1)


func update_selector(new_id):
	current_id_color = new_id


func check_legit_pos(pos, region):
	var result = true

	if !(pos[0] in range(region[0][0], region[1][0])):
		result = false

	if !(pos[1] in range(region[0][1], region[1][1])):
		result = false

	return result

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

