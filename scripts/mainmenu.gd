extends CanvasLayer


func _ready():
	if get_node("/root/global").sound:
		get_node("TextureButton_sound").set_pressed(false)
	else:
		get_node("TextureButton_sound").set_pressed(true)
	
	get_tree().set_pause(false)
	
	get_tree().set_auto_accept_quit(true)
	
	get_node("/root/global").reset()
	
	if int(rand_range(0,2)) == 0:
		get_node("/root/global").show_interstitial()

func _on_TextureButton_play_pressed():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").goto_scene(get_node("/root/global").GetLevel())
	

func _on_TextureButton_scores_pressed():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").goto_scene(get_node("/root/global").GetLevel(true))



func _on_TextureButton_exit_pressed():
	get_node("/root/sfx").PlaySound("dialog")
	get_node("dlg_exit_2_dos").show()
	get_tree().set_pause(true)


func _on_TextureButton_sound_pressed():
	get_node("/root/sfx").PlaySound("click")
	get_node("/root/global").sound = !get_node("/root/global").sound 


