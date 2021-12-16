extends Node2D

<<<<<<< HEAD
=======
#
#https://gdscript.com/solutions/signals-godot/


>>>>>>> 97f710f4c70ab28bfda1a49262024f95747e7fe7
var map_node

var build_mode = false # avisa se esta no modo construcao
var build_valid = false
var build_type
var build_location
<<<<<<< HEAD
var build_tile

var current_wave = 0
var enemies_in_wave

##################################
####Building  Functions
#################################
=======
var buid_title

var onda_inimigos_atual = 0
var inimigos_ainda_vivos = 0
>>>>>>> 97f710f4c70ab28bfda1a49262024f95747e7fe7

# Called when the node enters the scene tree for the first time.
func _ready():
	map_node = get_node("Mapa")
	
	for i in get_tree().get_nodes_in_group('build_botoes'):
<<<<<<< HEAD
		i.connect('pressed',self,'iniciar_botao', [i.get_name()])
		#i.connect('pressed',self,'iniciar_botao', t)
	
	start_next_wave() #At the bottom of this script
=======
		#print('i: ', i)
		var t = i.get_name()
		#print('t: ', t)
		i.connect('pressed',self,'iniciar_botao', [t])
		#i.connect('pressed',self,'iniciar_botao', t)
	start_next_wave()

#######################################################################
#
#  Funções para construção de torres
#
########################################################################
>>>>>>> 97f710f4c70ab28bfda1a49262024f95747e7fe7

func iniciar_botao(tipo_de_torre):
	if build_mode :
		cancel_build_mode()
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
		buid_title =  title_atual
	
	else:
		get_node('UI').update_tower_preview(title_position, "ff002a")
		build_valid =false
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	#get_node("UI/tower_preview").queue_free()
	get_node("UI/tower_preview").free() # delete imediatamente
	pass
<<<<<<< HEAD

=======
	
	
>>>>>>> 97f710f4c70ab28bfda1a49262024f95747e7fe7
func verify_and_build():
	var new_tower
	if build_valid:
		if build_type == 'TowerRed':
			new_tower = load('res://Elements/Tower/TowerRed.tscn').instance()
	 
		elif build_type == 'TowerGreen':
			new_tower = load('res://Elements/Tower/TowerGreen.tscn').instance()
		new_tower.position = build_location
		new_tower.built = true
		map_node.get_node("Torres").add_child(new_tower,true)
		
		map_node.get_node("towerexclusion").set_cellv(buid_title , 2) # colocando o title obstructed cujo id eh 2 no mapa


func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	elif event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

#######################################################################
#
#  Funções para construção de torres
#
########################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if build_mode:
		update_tower_preview()
	else:
		#olhe_para()
		print()
	pass

#######################################################################
#
#  Funções para inimigos
#
########################################################################

func start_next_wave(): # roda quando da play e  qd o player mata toda a onda
	var onda = retrieve_wave_data()
	yield(get_tree().create_timer(0.5), "timeout")#padding
	spawn_enemies(onda)

func retrieve_wave_data():
	var dados_inimigos = [['EnemyRed', 2] , ['EnemyGreen', 0.9]]
	onda_inimigos_atual += 1
	inimigos_ainda_vivos = dados_inimigos.size()
	return dados_inimigos
	
func spawn_enemies(onda):
	for i in onda:
		var new_inimigo = load('res://Elements/Enemy/' + i[0] + ".tscn").instance()
		map_node.get_node('Path').add_child(new_inimigo,true)
		yield(get_tree().create_timer(i[1]), "timeout")#padding
	
	pass
<<<<<<< HEAD

## WAVE FUNCTIONS

func start_next_wave():
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2), "timeout") #padding between wave so they dont start instan
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["EnemyBasic", 0.7], ["EnemyBasic", 0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	
	return wave_data
	
func spawn_enemies (wave_data):
	for i in wave_data:
		var new_enemy = load("res://Elements/Enemy/" + i[0] + ".tscn").instance()
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]), "timeout")
=======
	
#######################################################################
#
#  Funções para inimigos
#
########################################################################


>>>>>>> 97f710f4c70ab28bfda1a49262024f95747e7fe7
