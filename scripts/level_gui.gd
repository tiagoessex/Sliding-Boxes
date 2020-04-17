extends CanvasLayer



func _ready():
	if get_node("/root/global").sound:
		get_node("TextureButton_sound").set_pressed(false)
	else:
		get_node("TextureButton_sound").set_pressed(true)


func _on_TextureButton_menu_pressed():
	get_node("/root/sfx").PlaySound("dialog")
	get_node("dlg_areyousure").show()
	get_tree().set_pause(true)
	get_node("..").hide_squares(true)


func _on_TextureButton_sound_pressed():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").sound = !get_node("/root/global").sound 
	if get_node("/root/global").sound:
		get_node("TextureButton_sound").set_pressed(false)
	else:
		get_node("TextureButton_sound").set_pressed(true)



func _on_TextureButton_again_pressed():
	get_node("/root/global").gameover = true
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").goto_scene(get_node("/root/global").GetLevel())
