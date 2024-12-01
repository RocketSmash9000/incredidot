extends Node2D
# Define variables under this comment and above func _ready()

var debug_text = ""

var show_menu = false # Self-explanatory
var hide_menu = false

# Called every time the node gets loaded into a scene.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"): # Toggles fullscreen
		if DisplayServer.window_get_mode() == 3: # 3 = fullscreen enabled
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else: # If it's not 3, enable fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if Input.is_action_just_pressed("debug_key"): # Shows debug info node
		$"Static elements/Debug".visible = !$"Static elements/Debug".visible
	
	debug_text = "Mouse up: " + str(GlobalVars.mouse_up) + "\n" + "Carrying: " + str(GlobalVars.carrying_icon) + "\n" + "Picked polos: " + str(GlobalVars.picked_polos) + "\n" + "Mouse in top: " + str(GlobalVars.mouse_in_top_part) + "\n" + "Mouse in bottom: " + str(GlobalVars.mouse_in_bottom_part) + "\n" + "Icon meta: " + str(GlobalVars.icon_meta) + "\n" + "Reset: " + str(GlobalVars.reset) 
	
	if $"Static elements/Debug".visible: # Displays a bunch of text in real time
		$"Static elements/Debug".text = (debug_text)
	
	if show_menu: # Shows the menu when the menu button is pressed
		$"Static elements/ResetButton".position.x += delta*2200
		$"Static elements/CloseMenu".position.x += delta*2200
		$"Static elements/MenuIcon".position.x += delta*2200
		if $"Static elements/CloseMenu".position.x >= 1800:
			show_menu = false
	
	if hide_menu: # Hides the menu when the close menu button is pressed
		$"Static elements/ResetButton".position.x -= delta*2200
		$"Static elements/CloseMenu".position.x -= delta*2200
		$"Static elements/MenuIcon".position.x -= delta*2200
		if $"Static elements/MenuIcon".position.x <= 20:
			hide_menu = false
	
	# From x = 1512 to x = 1960 in loop_seconds * loop_amount
	if !GlobalVars.picked_polos.is_empty():
		$"Static elements/ProgressBar".position.x += (448/(GlobalVars.loop_seconds*GlobalVars.loop_amount))*delta
	
	if $"Static elements/ProgressBar".position.x >= 1960 or GlobalVars.picked_polos.is_empty():
		$"Static elements/ProgressBar".position.x = 1512


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


func _when_menu_icon_pressed() -> void:
	show_menu = true


func _when_close_menu_pressed() -> void:
	hide_menu = true


func _when_reset_button_pressed() -> void:
	GlobalVars.reset = true
