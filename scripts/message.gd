extends Control

export var message = "Swipe the white square torwards the hole!"

func _ready():
	get_node("Label").set_text(message)
