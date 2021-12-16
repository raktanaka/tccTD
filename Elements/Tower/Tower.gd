extends Node2D

var type
var enemy_array = []
var built = false
var enemy


func _ready():
	if built:
		self.get_node("ViewRadius/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[self.get_name()]["range"]
		pass


func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		#select_enemy()
		olhe_para()
		#if ready:
			#fire()
	else:
		enemy = null
		

func select_enemy ():
	var enemy_progress_array = [] # o quanto o inimigo andou no caminho ...
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find (max_offset)
	enemy = enemy_array[enemy_index]

#func fire():
	#ready = false
	#enemy.on_hit(GameData.tower_data[type]["damage"])
	#yield(get_tree().create_timer(GameData.tower_data[type]["rof"]), timeout)
	#ready = true

func olhe_para():
	#var enemy_position = get_global_mouse_position()
	get_node(".").look_at(enemy.position)
	pass


func _on_ViewRadius_body_entered(body):
	print(get_name())
	print('enter')
	

func _on_ViewRadius_body_exited(body):
	print(get_name())
	print('out')
	
	
