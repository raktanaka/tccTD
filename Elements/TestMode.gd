extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	load_test_menu()
	
func load_test_menu():
	get_node("TestMenu/buttons/TestMode").connect("pressed",self,"start_test")
	get_node("TestMenu/buttons/Return").connect("pressed",self,"return_main")
	
func start_test():
	pass
	get_node("Menu").queue_free()
	var scene = load('res://Elements/MainScene.tscn').instance()
	scene.connect("game_finished",self, 'unload_game')
	add_child(scene)

func return_main():
	get_node("TestMenu").queue_free()
	var main_menu = load('res://Elements/GerenciarCena.tscn').instance()
	add_child(main_menu)
	
	
