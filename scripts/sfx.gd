extends SamplePlayer

func StopAll():
	stop_all()


func PlaySound(which):
	
	if not get_node("/root/global").sound:
	#	print ("no sound")
		return
	if which == "click":
		play("click")
	elif which == "dialog":
		play("dialog")
	elif which == "victory":
		play("victory")
	elif which == "swap":
		play("swap")
	elif which == "wall":
		play("wall")
	elif which == "gameover":
		play("gameover")
	elif which == "level":
		play("level_passage")
	else:
		print ("SOUND ERROR")
