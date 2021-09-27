extends Node2D

#
#https://gdscript.com/solutions/signals-godot/

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map_node
var build_mode = false # avisa se esta no modo construcao
var build_valid = false
var build_type
var build_location

# Called when the node enters the scene tree for the first time.
func _ready():
	map_node = get_node("Mapa")
	
	for i in get_tree().get_nodes_in_group('build_botoes'):
		print('i: ', i)
		var t = i.get_name()
		print('t: ', t)
		i.connect('pressed',self,'iniciar_botao', [t])
		#i.connect('pressed',self,'iniciar_botao', t)


func iniciar_botao(tipo_de_torre):
	build_type = tipo_de_torre
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_position())
	pass

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	#determinam a posicao exata para carregar a texture da  torre
	var title_atual    = map_node.get_node('towerexclusion').world_to_map(mouse_position) # coordenadas
	var title_position = map_node.get_node('towerexclusion').map_to_world(title_atual)
	
	# 
	if map_node.get_node('towerexclusion').get_cellv(title_atual) == -1: # o nó é um lugar que vc nao pode construir
		get_node("UI").update_tower_preview(title_position, "d8b0b0")
		build_valid = true
		build_location= title_position
	
	else:
		get_node('UI').update_tower_preview(title_position, "ff002a")
		build_valid =false
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/tower_preview").queue_free()
	pass
func verify_and_build():
	var new_tower
	if build_valid:
		if build_type == 'torrevermelha':
			new_tower = load('res://Elements/TowerRed.tscn').instance()
	 
		elif build_type == 'torreverde':
			new_tower = load('res://Elements/TowerGreen.tscn').instance()
		new_tower.position = build_location
		map_node.get_node("Torres").add_child(new_tower,true)
		
		
				
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	elif event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if build_mode:
		update_tower_preview()
#	
	pass
