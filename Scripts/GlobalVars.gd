extends Node

var mouse_up = false # Controls when the mouse has been unclicked
var icon_meta = 0 # Metadata of the carried icon, aka its identifier
var carrying_icon = false # Self-explanatory

# These are used to detect whether the mouse is in the top or bottom part of the screen
var top_detector_entered = false
var bottom_detector_entered = false
var top_detector_exited = false
var bottom_detector_exited = false

var mouse_in_top_part = false
var mouse_in_bottom_part = false

var picked_polos = [] # Used to keep track of the polos that have been picked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print(mouse_up, carrying_icon)
	if top_detector_entered and bottom_detector_exited: # If this triggers, the mouse is in the top part
		mouse_in_top_part = true
		mouse_in_bottom_part = false
		print("top")
	if top_detector_exited and bottom_detector_entered: # If this triggers, the mouse is in the bottom part
		mouse_in_bottom_part = true
		mouse_in_top_part = false
		print("bottom")
