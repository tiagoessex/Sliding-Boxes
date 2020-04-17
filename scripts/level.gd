extends Node

var blocks = 1

func _ready():
	
#	var delta = Vector2((get_viewport().get_rect().size.x - 720) / 2 , 0)
#	var sq = get_node("squares").get_children()
#	var wl = get_node("walls").get_children()
#	var tg = get_node("targets").get_children()
#	for s in sq:
#		s.move_to(s.get_pos() + delta)
#	for w in wl:
#		w.set_pos(w.get_pos() + delta)
#	for t in tg:
#		t.set_pos(t.get_pos() + delta)
	
	get_node("level_gui/Label_level").set_text(str("Level: ", get_node("/root/global").level))
	get_tree().set_pause(true)
	hide_squares(true)
	get_node("AnimationPlayer_start").set_active(true)
	get_node("AnimationPlayer_start").play("New Anim")
	get_node("/root/global").gameover = false
	
	blocks = get_node("targets").get_child_count()
	
	if int(rand_range(0,5)) == 0:
		get_node("/root/global").show_interstitial()


func SquareInPlace():
	blocks -= 1
	if blocks <= 0:
		NextLevel()

func NextLevel():

	if not get_node("/root/global").NextLevel():
		Victory()
	else:
		get_tree().set_pause(true)
		hide_squares(true)
		get_node("AnimationPlayer").set_active(true)
		get_node("AnimationPlayer").play("New Anim")
		get_node("/root/sfx").PlaySound("level")
	

func Victory():
	get_node("/root/sfx").PlaySound("victory")
	get_node("level_gui/victory").show()
	get_node("/root/global").gameover = true


func GameOver():
	if get_node("/root/global").gameover:
		return
	get_node("/root/global").gameover = true
	get_node("/root/sfx").PlaySound("gameover")
	get_node("level_gui/dlg_again").show()

func hide_squares(w):
	var all_others = get_node("squares").get_children()
	
	for square in all_others:
		if square.has_method("isBox"):
			square.hideSquare(w)

func _on_AnimationPlayer_finished():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene(get_node("/root/global").GetLevel())
	


func _on_AnimationPlayer_start_finished():
	get_tree().set_pause(false)
	hide_squares(false)
