extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var grid
var pointer
var pointer_right
var color_picker
var TesterBackGround
var BlocksTester
var Editor 
var Testor
var Grid 

var current_pos = Vector2(0,0)
var primary_id_color = -1
var secondary_id_color = -1
var current_level_id = 1

var ground_region = [[0,0], [10,10]]
var color_region = [[1,11], [6,13]]
var blocker_region = [[7,11], [9,13]]


# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_node("Editor/Grid")
	pointer = get_node("Editor/Pointer")
	pointer_right = get_node("Editor/Pointer Right")
	color_picker = get_node("Editor/ColorPicker")
	TesterBackGround = get_node("Tester/TestBackGround")
	BlocksTester = get_node("Tester/Blocks")
	Editor = get_node("Editor")
	Testor = get_node("Tester")
	Grid = get_node("Editor/Grid")
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("placeBlock"):
		current_pos = get_viewport().get_mouse_position()

		if check_legit_pos(grid.convert_to_cell_pos(current_pos), ground_region):
			grid.change_tile(current_pos, primary_id_color)

		if check_legit_pos(pointer.convert_to_cell_pos(current_pos), color_region):
			pointer.set_primary(current_pos)
			update_primary_color(color_picker.get_color_id(current_pos))

		if check_legit_pos(pointer.convert_to_cell_pos(current_pos), blocker_region):
			pointer.set_primary(current_pos)
			update_primary_color(color_picker.get_color_id(current_pos))


	if Input.is_action_pressed("removeBlock"):
		current_pos = get_viewport().get_mouse_position()

		if check_legit_pos(grid.convert_to_cell_pos(current_pos), ground_region):
			grid.change_tile(current_pos, secondary_id_color)
			
		if check_legit_pos(grid.convert_to_cell_pos(current_pos), blocker_region):
			pointer_right.set_secondary(current_pos)
			update_secondary_color(color_picker.get_color_id(current_pos))
			
		if check_legit_pos(pointer.convert_to_cell_pos(current_pos), color_region):
			pointer_right.set_secondary(current_pos)
			update_secondary_color(color_picker.get_color_id(current_pos))
			

	if Input.is_action_pressed("pick color 1"):
		update_primary_color(0)
		var world_pos = color_picker.get_pos_color_from_number(0)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 2"):
		update_primary_color(1)
		var world_pos = color_picker.get_pos_color_from_number(1)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 3"):
		update_primary_color(2)
		var world_pos = color_picker.get_pos_color_from_number(2)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 4"):
		update_primary_color(3)
		var world_pos = color_picker.get_pos_color_from_number(3)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 5"):
		update_primary_color(4)
		var world_pos = color_picker.get_pos_color_from_number(4)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 6"):
		update_primary_color(5)
		var world_pos = color_picker.get_pos_color_from_number(5)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 7"):
		update_primary_color(6)
		var world_pos = color_picker.get_pos_color_from_number(6)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 8"):
		update_primary_color(7)
		var world_pos = color_picker.get_pos_color_from_number(7)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 9"):
		update_primary_color(8)
		var world_pos = color_picker.get_pos_color_from_number(8)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("pick color 10"):
		update_primary_color(9)
		var world_pos = color_picker.get_pos_color_from_number(9)
		pointer.set_primary(world_pos)
		pass
		
	if Input.is_action_pressed("erase"):
		update_primary_color(-1)
		pointer.set_primary(Vector2(232, 398))
		pass


func update_primary_color(new_id):
	primary_id_color = new_id
	

func update_secondary_color(new_id):
	secondary_id_color = new_id


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

func _on_Test_pressed():
	Editor.visible = false
	Testor.visible = true
	
#	print(current_level_id)
	current_level_id = Grid.get_level_id()
	TesterBackGround.update_ui(current_level_id)
	BlocksTester.clear_cache()
	BlocksTester.update_ui(current_level_id)
	pass



func _on_Edit_pressed():
	Editor.visible = true
	Testor.visible = false
	
	grid.load_file()
	grid.update_grid_from_save(current_level_id)
	grid._on_Level_text_changed()
	grid.set_selector(current_level_id)
	pass # Replace with function body.
