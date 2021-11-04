extends PathFollow2D


 #https://godotengine.org/qa/43840/how-do-pass-in-arguments-parent-script-when-extending-script
class_name INIMIGO

signal base_damage(d)

# id of the enemy to organize data produced
var id 

var destroying = false

var speed
var base_damage

var hp = 100.0
var move_direction = 0

#measure how much time the enemy survived
var time_start
var time_elapsed

var reached_goal = false

onready var path_follow = get_parent()
onready var health_bar = get_node("HealthBar")


func set_speed(s):
	speed = s
	
	
func set_base_damage(d):
	base_damage = d
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_toplevel(true)#disconecta a rotacao
	id = AI.id()

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0 && !destroying:
		destroying = true
		on_destroy()

func on_destroy():
	if hp > 0:
		reached_goal = true
	var data = []
	data.append(reached_goal)
	data.append(time_elapsed)
	AI.population_res[id] = data
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	## Check how much time the enemy will survive
	var time_now = OS.get_unix_time()
	time_elapsed = time_now - time_start

func _physics_process(delta):
	# unit_offset variavel que verifica o quanto do caminho foi percorrido
	# unit_offset é zero quando o inimigo nao andou nada e 1 quando completou o caminho
	
	if unit_offset >= 0.99 && !destroying: 
		destroying = true
		emit_signal("base_damage", base_damage)
		on_destroy()
	elif unit_offset >= 0.99:
		pass
	else:
		move(delta,speed)
		health_bar.set_position(position - Vector2(30,30))

func move(delta,speed):
	set_offset(get_offset() + speed * delta)
