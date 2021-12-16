extends KinematicBody2D

var speed = 1.5
var move_direction = 0
onready var path_follow = get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#if GameData.jogo_comecou:
		MovementLoop(delta)

func MovementLoop(delta):
	var pos_ini = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed + delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(pos_ini) / 3.14) * 100
