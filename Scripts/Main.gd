extends Node2D
# Define variables under this comment and above func _ready()

var debug_text = ""

var show_menu = false # Self-explanatory
var hide_menu = false

var once = true # used to trigger stuff only once. Yk, code executing every frame.

var first_polo = true # True when there are no polos picked

# Called every time the node gets loaded into a scene.
func _ready() -> void:
	# Sets the wait time of the timer to the duration of a loop
	$Loop.wait_time = GlobalVars.loop_seconds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"): # Toggles fullscreen
		if DisplayServer.window_get_mode() == 3: # 3 = fullscreen enabled
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else: # If it's not 3, enable fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if Input.is_action_just_pressed("debug_key"): # Shows debug info node
		$"Static elements/Debug".visible = !$"Static elements/Debug".visible
	
	if $"Static elements/Debug".visible: # Displays a bunch of text in real time
		debug_text = "Mouse up: " + str(GlobalVars.mouse_up) + "\n" + "Carrying: " + str(GlobalVars.carrying_icon) + "\n" + "Picked polos: " + str(GlobalVars.picked_polos) + "\n" + "Mouse in top: " + str(GlobalVars.mouse_in_top_part) + "\n" + "Mouse in bottom: " + str(GlobalVars.mouse_in_bottom_part) + "\n" + "Icon meta: " + str(GlobalVars.icon_meta) + "\n" + "Reset: " + str(GlobalVars.reset) + "\n" + "Current loop: " + str(GlobalVars.current_loop)
		$"Static elements/Debug".text = (debug_text)
	
	if show_menu: # Shows the menu when the menu button is pressed
		Log.debug("Showing menu...")
		toggle_progressbar_visibility(false)
		var animator = create_tween()
		animator.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
		animator.set_trans(Tween.TRANS_SINE)
		animator.set_ease(Tween.EASE_IN_OUT)
		animator.set_parallel(true)
		animator.tween_property($"Static elements/CloseMenu", "position", Vector2(1808, 16), 0.5)
		animator.tween_property($"Static elements/ResetButton", "position", Vector2(24, 16), 0.5)
		animator.tween_property($"Static elements/MenuIcon", "position", Vector2(1952, 16), 0.5)
		animator.play()
		show_menu = false
	
	if hide_menu: # Hides the menu when the close menu button is pressed
		Log.debug("Hiding menu...")
		toggle_progressbar_visibility(true)
		var animator2 = create_tween()
		animator2.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
		animator2.set_trans(Tween.TRANS_SINE)
		animator2.set_ease(Tween.EASE_IN_OUT)
		animator2.set_parallel(true)
		animator2.tween_property($"Static elements/CloseMenu", "position", Vector2(-128, 16), 0.5)
		animator2.tween_property($"Static elements/ResetButton", "position", Vector2(-1912, 16), 0.5)
		animator2.tween_property($"Static elements/MenuIcon", "position", Vector2(16, 16), 0.5)
		animator2.play()
		hide_menu = false
	
	# Delete or comment out this block in case you don't want the progress bar, or prefer using a custom one
	if !GlobalVars.picked_polos.is_empty():
		$"Static elements/ProgressBar".position.x += (448/(GlobalVars.loop_seconds*GlobalVars.loop_amount))*delta
	if $"Static elements/ProgressBar".position.x >= 1960 or GlobalVars.picked_polos.is_empty():
		$"Static elements/ProgressBar".position.x = 1512
	
	
	# Once there are polos, start a timer
	if once and !GlobalVars.picked_polos.is_empty():
		$Loop.start()
		once = false
	
	# if there are no polos or if the polos were reset, stop the timer.
	if (!once and GlobalVars.picked_polos.is_empty()) or GlobalVars.reset:
		$Loop.stop()
		once = true
	
	if !first_polo and GlobalVars.picked_polos.is_empty():
		first_polo = true # Sets this variable to true when there are no picked polos

# These need no explanation whatsoever, I think
func _when_menu_icon_pressed() -> void:
	show_menu = true

func _when_close_menu_pressed() -> void:
	hide_menu = true

func _when_reset_button_pressed() -> void:
	GlobalVars.reset = true


func _when_loop_timeout() -> void:
	# Once the timer fires an alarm, set the current loop to +1 of its old value
	if !GlobalVars.picked_polos.is_empty():
		GlobalVars.current_loop += 1
		# Or set it back to 1 if it's higher than the max amount of loops
		if GlobalVars.current_loop > GlobalVars.loop_amount:
			GlobalVars.current_loop = 1
	else:
		GlobalVars.reset = true # If the timer fires an alarm but the list is empty, force a reset.
	
	# These are used to sync the progress bar to the timer in case it is desynced
	if $"Static elements/ProgressBar".position.x < 1736 and GlobalVars.current_loop == 2:
		$"Static elements/ProgressBar".position.x = 1736
	elif $"Static elements/ProgressBar".position.x < 1960 and GlobalVars.current_loop == 1:
		$"Static elements/ProgressBar".position.x = 1512

func toggle_progressbar_visibility(visibility):
	# Detects if the visibility is actually going to be changed
	# If it's not, does nothing.
	# If true is passed, makes the progressbar visible
	# If false is passed, makes the progressbar invisible
	if $"Static elements/ProgressBar".visible != visibility:
		$"Static elements/ProgressBar".visible = visibility
		$"Static elements/ProgressCover".visible = visibility
		$"Static elements/ProgressCover2".visible = visibility
		$"Static elements/BaseProgressBar".visible = visibility
