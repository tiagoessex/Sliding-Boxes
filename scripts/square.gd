extends KinematicBody2D

const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const IDLE = Vector2(0,0)

const SPEED = 15
const SWIPE_DISTANCE = 20
const SWIPE_TIME = 0.05
#const TARGET_DISTANCE = 10

var bStart = false
var action_time = 0
var initial_pos = Vector2(0,0)
var speed_dir = IDLE

var bMoving = false

var bGo2Target = false
#var target_pos

onready var tween = get_node("Tween")
var property = "transform/pos"
var dlt = 0

var bDone = false


var bHide = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)

	

func hideSquare(what):
	bHide = what
	if not what:
		get_node("Timer").start()
	else:
		set_pickable(false)


func _fixed_process(delta):
	if bGo2Target:
		return

	if bStart:
		action_time +=delta
	if bMoving:
		dlt = delta
		move(speed_dir * SPEED)
	
	if speed_dir == IDLE and bMoving:
		bMoving = false
	
	if (is_colliding()): 
		action_time = 0
		bStart = false
		speed_dir = IDLE
		#print ("COL")
		get_node("/root/sfx").PlaySound("wall")


func _input(event):
	if bHide:
		return

	if event.type == InputEvent.MOUSE_BUTTON and not event.pressed and event.button_index == BUTTON_LEFT and bStart:
		bStart = false
		action_time = 0

	if bStart:
		if action_time > SWIPE_TIME:
			action_time = 0
			var final_pos = event.pos
			var hor = final_pos.x - initial_pos.x
			var vert = final_pos.y - initial_pos.y
			if abs(hor) > abs(vert):
				if hor > SWIPE_DISTANCE:
					speed_dir = RIGHT
					bMoving = true
				if hor < -SWIPE_DISTANCE:
					speed_dir = LEFT
					bMoving = true
			else:
				if vert > SWIPE_DISTANCE:
					speed_dir = DOWN
					bMoving = true
				if vert < -SWIPE_DISTANCE:
					speed_dir = UP
					bMoving = true

func _on_square_input_event( viewport, event, shape_idx ):

	if bHide:
		return
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == BUTTON_LEFT and speed_dir == IDLE:
		bStart = true
		action_time = 0
		initial_pos = event.pos
		#event = get_node(".").make_input_local(event)

		# make sure that if overlaping then only
		# one can be selected
		var all_others = get_node("..").get_children()
		for square in all_others:
			if square.has_method("isBox") and square != self:
				if square.bStart:
					square.bStart = false
					



func goto(pos):
	bGo2Target = true
	set_fixed_process(false)
	set_process_input(false)
	move_too(pos)
	#get_node("/root/sfx").PlaySound("target")


func move_too(target_pos):
	var start = get_pos()
	var end = target_pos
	var distance = start.distance_to(end)
	var time = dlt * distance / SPEED

	if time <= 0: return

	if tween.is_active(): tween.stop(get_node("."), property)
	tween.interpolate_property(get_node("."), property, start, end, time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func isBox():
	return true



func _on_VisibilityNotifier2D_exit_screen():
	if bHide or get_node("/root/global").gameover:
		return
	#print ("OUT")
	get_node("../..").GameOver()
	queue_free()




func _on_Tween_tween_complete( object, key ):
	bDone = true
	#print ("DONE")
	get_node("../..").SquareInPlace()
	get_node("/root/sfx").PlaySound("swap")


func _on_Timer_timeout():
	bHide = false
	set_pickable(true)
