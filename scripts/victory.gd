extends Control




func _on_victory_visibility_changed():
	get_tree().set_pause(true)
	get_node("AnimationPlayer").play("New Anim")
	get_node("Timer").start()


func _on_Timer_timeout():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene("res://scenes/mainmenu.tscn")
