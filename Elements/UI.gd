extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_tower_preview(build_type, mouse_position) :
	var arrastar
	if build_type == 'torrevermelha':
		arrastar = load('res://Elements/TowerRed.tscn').instance()
	 
	elif build_type == 'torreverde':
		arrastar = load('res://Elements/TowerGreen.tscn').instance()
		
	arrastar.set_name('dragTower')
	arrastar.modulate = Color("d8b0b0")
	var control =  Control.new()
	control.add_child(arrastar, true)
	control.rect_position = mouse_position
	control.set_name('tower_preview')
	add_child(control,true)
	move_child(get_node('tower_preview'),0)
	
func update_tower_preview(new_position, coloor):
	get_node('tower_preview').rect_position = new_position
	if get_node('tower_preview/dragTower').modulate != Color(coloor) :
		get_node('tower_preview/dragTower').modulate = Color(coloor)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
