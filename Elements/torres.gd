extends Node2D



func olhe_para():
	var enemy_position = get_global_mouse_position()
	get_node(".").look_at(enemy_position)
	pass

func disparo(delta):
#	var tiro = preload("res://Elements/Disparo.tscn").instance()
#	var torres = get_tree().get_root().get_children()
#	print(torres)
#	print(torres[0]) 
#	print(torres[0].get_name()) 
	pass


func _on_ViewRadius_body_entered(body):
	pass 

func _physics_process(delta):
	olhe_para()
	
#	if Input.is_action_pressed("atirar"): 
#		yield(get_tree().create_timer(0.09), "timeout")
#		if Input.is_action_just_released("atirar"):
#			print('CLICK')
#			disparo(delta)
	pass
	
