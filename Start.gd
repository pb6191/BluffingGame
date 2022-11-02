extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.iter == 0:
		$"RichTextLabel".text = "These are training trials, please work with your experimenter to understand the rules of the game. There will be a total of 100 trials."
	else:
		$"RichTextLabel".text = "You will face opponent #"+str(global.iter)+" now. There will be a total of 100 trials but only 1 trial is real. Your winnings would be whatever you win in that Real trial."
	if global.iter == 4:
		$"Button".visible = false
		$"RichTextLabel".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
