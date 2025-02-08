extends Area2D
# Define variables under this comment and above func _ready()

var mouse_in = false
var picked = false
var type = 0
var local_loop

const default_anim = preload("res://Assets/Unselected_polos/Unselected.tres")

var polostream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polostream = LogStream.new("Polo" + str(get_meta("PoloID")))
	# Creates a 'y' coordinate offset that results in the signature height difference. 85 is tiny and 48 is tall. Counterintuitive, but that's Godot for you.
	# Anyway, all polos do the appearing thing when first booting the project
	$Sprite2D.position.y = 504
	await get_tree().create_timer(sqrt(get_meta("PoloID"))/10).timeout
	var animator = create_tween()
	animator.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	animator.set_trans(Tween.TRANS_EXPO)
	animator.set_ease(Tween.EASE_OUT)
	animator.tween_property($Sprite2D, "position", Vector2($Sprite2D.position.x, randi() % 85 + 48), 0.5)
	animator.play()
	# Creates an offset for the default polo animation so that all polos are desynced
	randomize()
	$Sprite2D.frame = randi() % 50


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
			$AudioStreamPlayer.sound_play()
			if GlobalVars.current_loop == 1:
				# Sets the polo animation to its corresponding type
				$Sprite2D.sprite_frames = GlobalVars.set_polo_animation(type)
				polostream.debug("Animation for 1st loop set!")
			else:
				$Sprite2D.sprite_frames = GlobalVars.set_polo_animation(type)
				# If animation FPS = 30 and loop = 6s, frame for next loop = 180
				$Sprite2D.frame = 180
				polostream.debug("Animation for 2nd loop set!")
			local_loop = GlobalVars.current_loop
	
		if Input.is_action_just_pressed("ui_click") and !GlobalVars.carrying_icon and picked:
			# This makes the polo become unselected again
			polostream.debug("Polo number " + str(get_meta("PoloID")) + " unpicked")
			GlobalVars.picked_polos.erase(type) # Removes polo type from used list
			type = 0 # Returns itself to original value
			picked = false # Sets polo to unused state
			GlobalVars.mouse_up = false
			$AudioStreamPlayer.stop()
			$AudioStreamPlayer.already_playing = false
			# Returns to its default animation when unpicked
			var animator = create_tween()
			animator.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
			animator.set_trans(Tween.TRANS_EXPO)
			animator.set_ease(Tween.EASE_OUT)
			animator.tween_property($Sprite2D, "position", Vector2($Sprite2D.position.x, 504), 0.2)
			animator.play()
			$Sprite2D.sprite_frames = default_anim
			$Sprite2D.frame = randi() % 50
			randomize()
			animator.tween_property($Sprite2D, "position", Vector2($Sprite2D.position.x, randi() % 85 + 48), 0.2)
			animator.play()
	
	if GlobalVars.reset: # Resets the polo when the reset is called
		type = 0
		picked = false
		$AudioStreamPlayer.stop()
		var animator = create_tween()
		animator.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
		animator.set_trans(Tween.TRANS_EXPO)
		animator.set_ease(Tween.EASE_OUT)
		animator.tween_property($Sprite2D, "position", Vector2($Sprite2D.position.x, 504), 0.1)
		animator.play()
		$Sprite2D.sprite_frames = default_anim
		$Sprite2D.frame = randi() % 50
		randomize()
		animator.tween_property($Sprite2D, "position", Vector2($Sprite2D.position.x, randi() % 85 + 48), 0.5)
		animator.play()
	

func _when_self_mouse_entered() -> void:
	mouse_in = true

func _when_self_mouse_exited() -> void:
	mouse_in = false
