extends Control


func _on_TextureButton_yes_pressed():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").save_game()
	get_node("/root/global").goto_scene("res://scenes/mainmenu.tscn")


func _on_TextureButton_no_pressed():
	get_node("/root/sfx").PlaySound("click")
	set_hidden(true)
	get_tree().set_pause(false)
	get_node("../TextureButton_menu").set_pressed(false)
	get_node("../..").hide_squares(false)


