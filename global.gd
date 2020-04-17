extends Node

const MAX_LEVELS = 17

var current_scene = null


var gameover = false
var sound = true
var level = 1
var level_name = ""
var continue_level = 1


var save_info = { "continue_level" : 1 }

var admob = null;
var admob_interstitial_id = "xxxxxxxxxxxxxxxxxx"



func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
	level_name = str("res://scenes/level_",level,".tscn")
	
	reset()
	
	load_shits()
	
	#print ("continue > ", continue_level)

	
	##############################################################
	############################### ADMOB ########################
	##############################################################
	

	if Globals.has_singleton("bbAdmob"):
		admob = Globals.get_singleton("bbAdmob")
		#You can call admob.init_admob_test or admob.init_admob_real
		#If the last argument is true, the banner ad will be at the top of the screen
		#Function prototype init_admob_banner_test(int instance_id, string app_banner_id, string app_interstitial_id, boolean isTop)
		#admob.init_admob_test(get_instance_ID(), admob_banner_id, admob_interstitial_id, false)
		admob.init_admob_interstitial_real(get_instance_ID(), admob_interstitial_id, true)


func show_interstitial():
	if admob != null:
		admob.show_interstitial()



func NextLevel():
	if level >= MAX_LEVELS:
		continue_level = 1
		level = 1
		save_game(true)
		return false
	level = level + 1
	save_game()
	return true

func GetLevel(cont = false):
	if not cont:
		return str("res://scenes/level_",level,".tscn")
	level = continue_level
	return str("res://scenes/level_",level,".tscn")


func reset():
	gameover = false
	level = 1
	level_name = str("res://scenes/level_",level,".tscn")


func load_shits():
#	print ("LOADING")
	var savegame = File.new()
	if not savegame.file_exists("user://pz_2.save"):
		print("Error opening file to load data")
		return
	else:
		savegame.open("user://pz_2.save", File.READ)
		save_info.parse_json(savegame.get_line())
		savegame.close() 
		continue_level = save_info["continue_level"]


func save_game(forced = false):
#	print ("SAVING")
	if  continue_level < level or forced:
		continue_level = level
#		print ("SAVING ... level: ", continue_level)
		var savegame = File.new()
		if savegame.open("user://pz_2.save", File.WRITE) != 0:
			print("Error opening file to save")
			return
		
		
		save_info["continue_level"] = continue_level
		savegame.store_line(save_info.to_json())
		
		savegame.close()


##################################
# SCENE LOGIC
##################################
func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )

