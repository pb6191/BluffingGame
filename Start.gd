extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"RichTextLabel".text = "You will face opponent #"+str(global.iter)+" now. There will be a total of 100 trials but only 1 trial is real. Your winnings would be whatever you win in that Real trial."
	if global.iter == 4:
		$"Button".visible = false
		$"RichTextLabel".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
