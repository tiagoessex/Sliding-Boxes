extends Area2D

var occupied = false

func isTarget():
	return true


func _on_target_body_enter( body ):
	if occupied:
		return
	if body.has_method("isBox"):
		occupied = true
		body.goto(get_pos())

	
	#print ("target contact 2")
