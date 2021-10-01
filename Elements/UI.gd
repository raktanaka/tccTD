extends CanvasLayer

signal start

#var tower_range = 350

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_tower_preview(build_type, mouse_position) :
	var arrastar
	if build_type == 'TowerRed':
		arrastar = load('res://Elements/Tower/TowerRed.tscn').instance()
	 
	elif build_type == 'TowerGreen':
		arrastar = load('res://Elements/Tower/TowerGreen.tscn').instance()
	
	#create range
	var range_texture = Sprite.new()
	range_texture.position = Vector2(32, 32)
	
	#scalate range
	var scaling = GameData.tower_data[build_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	
	#load image
	var texture = load("res://Assets/UI/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
		
	arrastar.set_name('dragTower')
	arrastar.modulate = Color("d8b0b0")
	var control =  Control.new()
	control.add_child(arrastar, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name('tower_preview')
	add_child(control,true)
	move_child(get_node('tower_preview'),0)
	
func update_tower_preview(new_position, coloor):
	get_node('tower_preview').rect_position = new_position
	if get_node('tower_preview/dragTower').modulate != Color(coloor) :
		get_node('tower_preview/dragTower').modulate = Color(coloor)
		get_node('tower_preview/Sprite').modulate = Color(coloor)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	GameData.jogo_comecou = true
	pass # Replace with function body.
