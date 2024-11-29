extends Node2D
# Define variables under this comment and above func _ready()

var debug_text = ""

# Called every time the node gets loaded into a scene.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"): # Toggles fullscreen
		if DisplayServer.window_get_mode() == 3: # 3 = fullscreen enabled
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else: # If it's not 3, enable fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if Input.is_action_just_pressed("debug_key"): # Shows debug info node
		$"Static elements/Debug".visible = !$"Static elements/Debug".visible
	
	debug_text = "Mouse up: " + str(GlobalVars.mouse_up) + "\n" + "Carrying: " + str(GlobalVars.carrying_icon) + "\n" + "Picked polos: " + str(GlobalVars.picked_polos) + "\n" + "Mouse in top: " + str(GlobalVars.mouse_in_top_part) + "\n" + "Mouse in bottom: " + str(GlobalVars.mouse_in_bottom_part) + "\n" + "Icon meta: " + str(GlobalVars.icon_meta) 
	
	if $"Static elements/Debug".visible: # Displays a bunch of text in real time
		$"Static elements/Debug".text = (debug_text)


# These functions calculate whether the mouse is in the top or bottom part of the screen
func _when_top_ui_mouse_entered() -> void:
	GlobalVars.top_detector_entered = true
	GlobalVars.top_detector_exited = false


func _when_top_ui_mouse_exited() -> void:
	GlobalVars.top_detector_exited = true
	GlobalVars.top_detector_entered = false


func _when_bottom_ui_mouse_entered() -> void:
	GlobalVars.bottom_detector_entered = true
	GlobalVars.bottom_detector_exited = false


func _when_bottom_ui_mouse_exited() -> void:
	GlobalVars.bottom_detector_exited = true
	GlobalVars.bottom_detector_entered = false
