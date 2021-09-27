extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Menu/botoes/NewGame").connect("pressed",self,"new_game_pressed")
	get_node("Menu/botoes/Quit").connect("pressed",self,"quit_pressed")
	pass # Replace with function body.
	
func new_game_pressed():
	print('new game')
	get_node("Menu").queue_free()
	var scene = load('res://Elements/MainScene.tscn').instance() 
	add_child(scene)
	
func quit_pressed():
	print('quit')
	get_tree().quit()
	
