extends Node2D

#
#https://gdscript.com/solutions/signals-godot/

signal game_finished(result)

var map_node
var build_mode = false # avisa se esta no modo construcao
var build_valid = false
var build_enemy = false
var build_type
var build_location
var build_tile

var onda_inimigos_atual = 0
var inimigos_ainda_vivos = 0
var base_health  = 100 # Doubled life, so the algorithm has more time to evolve
var total_damage = 0 # Damage logging for statistical purposes

# Automatic Test Mode variables
var test_towers
var test_enemies
var test_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	map_node = get_node("Mapa")
	
	for i in get_tree().get_nodes_in_group('build_botoes'):
		var t = i.get_name()
		i.connect('pressed',self,'iniciar_botao', [t])
	#start_next_wave()
	
# Test mode parameters
# towers: 		'AllGreen', 'AllRed', 'GreenRed', 'RedGreen'
# enemies: 'AI', 'Random', 'AllGreen', 'AllRed', 'AllBlue', 'AllGray', 'AllOrange'
func init_params(towers, enemies):
	test_mode = true
	test_towers = towers
	test_enemies = enemies

#######################################################################
#
#  Funções para construção de torres
#
########################################################################

func iniciar_botao(tipo_de_torre):
	if build_mode :
		cancel_build_mode()
	build_type = tipo_de_torre
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	#determinam a posicao exata para carregar a texture da  torre
	var tile_atual    = map_node.get_node('towerexclusion').world_to_map(mouse_position) # coordenadas
	var tile_position = map_node.get_node('towerexclusion').map_to_world(tile_atual)
	
	# 
	if map_node.get_node('towerexclusion').get_cellv(tile_atual) == -1: # o nó é um lugar que vc nao pode construir
		get_node("UI").update_tower_preview(tile_position, "d8b0b0")
		build_valid = true
		build_location= tile_position
		build_tile =  tile_atual
	
	else:
		get_node('UI').update_tower_preview(tile_position, "ff002a")
		build_valid = false
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	#get_node("UI/tower_preview").queue_free()
	get_node("UI/tower_preview").free() # delete imediatamente
	
func verify_and_build():
	var new_tower
	if build_valid:
#		print(build_type)
		new_tower = load("res://Elements/Tower/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		map_node.get_node("Torres").add_child(new_tower,true)
		# Blocks tower overlap, but bugs out because in test mode the id changes
		# due to the tree changes
		#map_node.get_node("towerexclusion").set_cellv(build_tile , 3) # colocando o tile obstructed cujo id eh 2 no mapa

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	elif event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()


func test_mode_build_towers():
	# Tested at locations (256, 448) and (640, 384)
	var tower_locations = PoolVector2Array()
	tower_locations = [Vector2(256, 448), Vector2(640, 384)]
	var tower_types = []
	match test_towers:
		'AllGreen':
			tower_types = ['TowerGreen', 'TowerGreen']
		'AllRed':
			tower_types = ['TowerRed', 'TowerRed']
		'GreenRed':
			tower_types = ['TowerGreen', 'TowerRed']
		'RedGreen':
			tower_types = ['TowerRed', 'TowerGreen']
	build_valid = true
	for i in range(tower_locations.size()):
		build_location = tower_locations[i]
		build_type = tower_types[i]
		verify_and_build()

#######################################################################
#
#  Função 'update'
#
########################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if build_mode:
		update_tower_preview()
	
	## build next wave
	if !build_enemy && get_tree().get_nodes_in_group("Enemy").size() == 0 && onda_inimigos_atual > 0:
		build_enemy = true
		var wave = AI.start_experiment()
		print(wave)
		start_next_wave_AI(wave)   #### DESCOBRI PQ SE DESCOMENTAR NEW GAME E QUIT PARAM DE FUNCIONAR


#######################################################################
#
#  Funções para inimigos
#
########################################################################


func start_next_wave(): # roda quando da play e qd o player mata toda a onda
	var wave = retrieve_wave_data()
	yield(get_tree().create_timer(0.5), "timeout")#padding
	spawn_enemies(wave)
	
# "Começa" a AI, gera nova wave
func start_next_wave_AI(wave): # roda quando da play e qd o player mata toda a onda
	yield(get_tree().create_timer(0.5), "timeout")#padding
	spawn_enemies(wave)

func retrieve_wave_data():
	var dados_inimigos = [['EnemyRed', 1], ['EnemyGreen', 0.9], ['EnemyGray', 0.2], ['EnemyOrange', 1], ['EnemyBlue', 0.1], ['EnemyGray', 0.2]]
	inimigos_ainda_vivos = dados_inimigos.size()
	return dados_inimigos
	
func spawn_enemies(wave):
	for i in wave:
		var new_inimigo = load('res://Elements/Enemy/' + i[0] + ".tscn").instance()
		new_inimigo.connect("base_damage",self, 'on_base_damage')
		map_node.get_node('Path').add_child(new_inimigo,true)
		yield(get_tree().create_timer(i[1]), "timeout")#padding
	
	onda_inimigos_atual += 1
	
	build_enemy = false

func on_base_damage(damage):
	total_damage += damage
	base_health = base_health - damage
	#print('damage...', 'hp: ', base_health)
	if base_health <= 0:
		write_data(total_damage)
		emit_signal("game_finished",false)
	else:
		get_node("UI").update_health_bar(base_health)

# File writing at
#   Windows: %APPDATA%\Godot\
#   macOS: ~/Library/Application Support/Godot/
#   Linux: ~/.local/share/godot/
# Only in test mode
func write_data(data):
	if test_mode:
		var path = 'user://' + test_towers + ' - ' + test_enemies + '.csv'
		var file = File.new()
	
		# All this to be able to append to file
		if file.file_exists(path):
			file.open(path, File.READ_WRITE)
			file.seek_end()
			file.store_string('; ')
		else:
			file.open(path, File.WRITE)
			
		file.store_string(str(data))
		file.close()
	else:
		pass
