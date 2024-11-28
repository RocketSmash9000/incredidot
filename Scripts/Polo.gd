extends Area2D

var mouse_in = false
var picked = false
var type = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_in and GlobalVars.mouse_in_top_part:
		if GlobalVars.mouse_up and !picked:
			mouse_in = false
			GlobalVars.mouse_up = false
			picked = true
			type = GlobalVars.icon_meta
			GlobalVars.carrying_icon = false
			print("Polo number ", get_meta("PoloID"), " picked with type ", type)
			GlobalVars.icon_meta = 0
		
		if Input.is_action_just_pressed("ui_click") and !GlobalVars.carrying_icon and picked:
			print("Polo number ", get_meta("PoloID"), " unpicked")
			type = 0
			picked = false
			GlobalVars.mouse_up = false


func _when_self_mouse_entered() -> void:
	mouse_in = true


func _when_self_mouse_exited() -> void:
	mouse_in = false
