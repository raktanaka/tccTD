extends PathFollow2D

class_name INIMIGO


var speed = 0

var hp = 100.0
var move_direction = 0

onready var path_follow = get_parent()
onready var health_bar = get_node("HealthBar")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_speed(s):
	speed = s

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_toplevel(true)

func on_hit(damage):
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()
		

func on_destroy():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#if GameData.jogo_comecou:
	print(speed)
	move(delta,speed)
	health_bar.set_position(position - Vector2(30,30))

func move(delta,speed):
	#if get_node('res://Elements/Enemy/EnemyRed.tscn'):
	#	print('VERMELHo')
	set_offset(get_offset() + speed * delta)
