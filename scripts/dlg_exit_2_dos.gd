extends Control


func _on_TextureButton_yes_pressed():
	get_tree().quit()


func _on_TextureButton_no_pressed():
	get_node("/root/sfx").PlaySound("click")
	set_hidden(true)
	get_tree().set_pause(false)
