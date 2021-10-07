extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_main_menu()
	pass # Replace with function body.
	
func load_main_menu():
	get_node("Menu/botoes/NewGame").connect("pressed",self,"new_game_pressed")
	get_node("Menu/botoes/Quit").connect("pressed",self,"quit_pressed")	
	
func new_game_pressed():
	print('new game')
	get_node("Menu").queue_free()
	var scene = load('res://Elements/MainScene.tscn').instance() 
	scene.connect("game_finished",self, 'unload_game')
	add_child(scene)
	
func unload_game(result):
	get_node("MainScene").queue_free()
	var main_menu = load('res://Elements/Menu.tscn').instance()
	add_child(main_menu)
	load_main_menu()
	
	
func quit_pressed():
	print('quit')
	get_tree().quit()
	
