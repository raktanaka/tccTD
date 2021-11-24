extends CanvasLayer

onready var hp_bar       = get_node("Control/infobar/HBoxContainer/Barradevida")
onready var hp_bar_tween = get_node("Control/infobar/HBoxContainer/Barradevida/Tween")
onready var ui_wave_num = get_node("Control/infobar/HBoxContainer/Wave_num")
var main_scene

#var tower_range = 350

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
	
func update_tower_preview(new_position, color):
	get_node('tower_preview').rect_position = new_position
	if get_node('tower_preview/dragTower').modulate != Color(color) :
		get_node('tower_preview/dragTower').modulate = Color(color)
		get_node('tower_preview/Sprite').modulate = Color(color)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	main_scene = get_parent()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





#setar botao como process para que ele nao pause a arvore toda
func _on_Button_pressed():
	
	if main_scene.build_mode:
		main_scene.cancel_build_mode()
	elif get_tree().is_paused():
		get_tree().paused = false
	elif main_scene.onda_inimigos_atual == 0:
		main_scene.start_first_wave()
	else :
		get_tree().paused = true
	pass # Replace with function body.

# Engine é uma variavel global propria do godot
func _on_speed_pressed():

	if main_scene.build_mode:
		main_scene.cancel_build_mode()
	elif Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)
	
func _on_speed4_pressed():
	if main_scene.build_mode:
		main_scene.cancel_build_mode()
	elif Engine.get_time_scale() == 4.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(4.0)
	
	
func update_health_bar(base_health):
	#hp_bar_tween.interpole_property(node, parameter, start_value, end_value,  duration, transistion_type, easing_type)
	hp_bar_tween.interpolate_property(hp_bar,'value', hp_bar.value, base_health, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hp_bar_tween.start()
	if base_health >= 60                         : 
		hp_bar.set_tint_progress("fb0f41")
	elif base_health <= 60 and base_health >= 25 : 
		hp_bar.set_tint_progress("e1be32")
	
	elif base_health < 25 and  base_health >= 2 :
		hp_bar.set_tint_progress("f64d0c")
	
	else                                         : 
		hp_bar.set_tint_progress("434c44")

func update_wave_num(x):
	ui_wave_num.text = str(x)
	

func _on_VOLTAR_MENU_pressed():

	get_tree().change_scene("res://Elements/GerenciarCena.tscn")
	


