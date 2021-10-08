extends Node2D

var type
var enemy_array = []
var built = false
var enemy
var ready = true

# todo no deve ter um nome proprio e unico no godot como esta usando get_name()
# na hora de construir uma torre do mesmo tipo em outro lugar da erro...
func _ready():
	if built:
		#self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[self.get_name()]["range"]
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
		if ready:
			fire()
	else:
		enemy = null
		

func select_enemy ():
	var enemy_progress_array = [] # o quanto o inimigo andou no caminho ...
	for i in enemy_array:
		enemy_progress_array.append(i.offset)
	
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find (max_offset)
	enemy = enemy_array[enemy_index]

func fire():
	ready = false
	# como ambos os tipos de torre vao usar a mesma animaçao de tiro
	# aqui ficara um pouco diferente do tutorial
	get_node("AnimationPlayer").play("Fire") # nome da animaçao
	
	enemy.on_hit(GameData.tower_data[type]["damage"])
	yield(get_tree().create_timer(GameData.tower_data[type]["rof"]), "timeout")
	ready = true

func turn():
	get_node(".").look_at(enemy.position)


func _on_ViewRadius_body_entered(body):
	enemy_array.append(body.get_parent())
	

func _on_ViewRadius_body_exited(body):
	enemy_array.erase(body.get_parent())
	
	
