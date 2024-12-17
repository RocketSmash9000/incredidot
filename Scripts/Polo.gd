extends Area2D
# Define variables under this comment and above func _ready()

var mouse_in = false
var picked = false
var type = 0
var local_loop

var polostream = LogStream.new("Polo")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mouse_in and GlobalVars.mouse_in_top_part: # If the mouse is on top of the polo and is in the top part
		if GlobalVars.mouse_up and !picked and GlobalVars.icon_meta != 0: # And if everything looks to be correct
			mouse_in = false
			GlobalVars.mouse_up = false
			picked = true # Sets itself to picked
			type = GlobalVars.icon_meta # Fetches the metadata of the icon
			GlobalVars.carrying_icon = false
			polostream.debug("Polo number " + str(get_meta("PoloID")) + " picked with type " + str(type))
			GlobalVars.picked_polos.append(type) # Adds polo to the used list
			GlobalVars.icon_meta = 0 # Clears the icon metadata
			# match meta -> depending on the meta and the current loop it will play a different sound
			local_loop = GlobalVars.current_loop
	
		if Input.is_action_just_pressed("ui_click") and !GlobalVars.carrying_icon and picked:
			polostream.debug("Polo number " + str(get_meta("PoloID")) + " unpicked")
			GlobalVars.picked_polos.erase(type) # Removes polo type from used list
			type = 0 # Returns itself to original value
			picked = false # Sets polo to unused state
			GlobalVars.mouse_up = false
			$AudioStreamPlayer.stop()
	
	if GlobalVars.reset: # Resets the polo when the reset is called
		type = 0
		picked = false
		$AudioStreamPlayer.stop()
	
	# When the current loop changes, play the next loop
	if local_loop != GlobalVars.current_loop and picked:
		# TODO: Play the animation corresponding to the polo and loop
		play_sound(type)
		local_loop = GlobalVars.current_loop


func _when_self_mouse_entered() -> void:
	mouse_in = true


func _when_self_mouse_exited() -> void:
	mouse_in = false


func play_sound(meta) -> void:
	# This function plays a sound corresponding to the polo meta and the current loop
	# If you need to add more sounds for more polos, copy and paste blocks
	# If there are not enough sounds, this function does nothing
	var sound_player = LogStream.new("Polo/play_sound")
	if GlobalVars.all_sounds.size() < GlobalVars.total_sounds:
		sound_player.warn("The total amount of sounds is incorrect. Returning to the main script...")
		return
	
	match meta:
		1:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[0])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[1])
		2:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[2])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[3])
		3:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[4])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[5])
		4:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[6])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[7])
		5:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[8])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[9])
		6:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[10])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[11])
		7:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[12])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[13])
		8:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[14])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[15])
		9:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[16])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[17])
		10:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[18])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[19])
		11:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[20])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[21])
		12:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[22])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[23])
		13:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[24])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[25])
		14:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[26])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[27])
		15:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[28])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[29])
		16:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[30])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[31])
		17:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[32])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[33])
		18:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[34])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[35])
		19:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[36])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[37])
		20:
			if GlobalVars.current_loop == 1:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[38])
			else:
				$AudioStreamPlayer.set_stream(GlobalVars.all_sounds[39])
		# Paste more blocks below here if needed
		
		# Paste more blocks above here if needed
		_: # If something goes wrong...
			sound_player.info("Cannot play any sound!")
	
	$AudioStreamPlayer.play()
