extends Node2D
# Define variables under this comment and above func _ready()


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
