extends PathFollow2D


 #https://godotengine.org/qa/43840/how-do-pass-in-arguments-parent-script-when-extending-script
class_name INIMIGO

signal base_damage(d)

var speed
var base_damage


var hp = 100.0
var move_direction = 0


onready var path_follow = get_parent()
onready var health_bar = get_node("HealthBar")


func set_speed(s):
	speed = s
	
	
func set_base_damage(d):
	base_damage = d
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_toplevel(true)#disconecta a rotacao

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		

func on_destroy():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	# unit_offset variavel que verifica o quanto do caminho foi percorrido
	# unit_offset é zero quando o inimigo nao andou nada e 1 quando completou o caminho
	
	#print( 'u: ', unit_offset, 's: ', speed , base_damage)
	if unit_offset > 0.9 : 
		#print("ENTROU AQUI EM UNITOFFSET")
		emit_signal("base_damage", base_damage)
		queue_free()
	move(delta,speed)
	health_bar.set_position(position - Vector2(30,30))

func move(delta,speed):
	#if get_node('res://Elements/Enemy/EnemyRed.tscn'):
	#	print('VERMELHo')
	set_offset(get_offset() + speed * delta)
