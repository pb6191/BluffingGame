extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.iter == 0:
		$"LineEdit".visible = true
		$"RichTextLabel".text = """These are training trials.

Please work with your experimenter to understand the rules of the game.

There will be a total of 20 trials.

You can rest anytime you like, get up, walk around, and question the experimenter.

Enter your code to start the game:"""
	elif global.iter == 1:
		$"LineEdit".visible = false
		$"RichTextLabel".text = """Training ENDS here and now the experiment BEGINS.
 
You will face opponent #"""+str(global.iter)+""" now.

There will be a total of 100 trials but only 1 trial is real.

Your winnings would be whatever you win in that Real trial.

If you lose in the Real trial, we won't take money from you.

You can rest anytime you like, get up, walk around, and question the experimenter."""
	else:
		$"LineEdit".visible = false
		$"RichTextLabel".text = """You will face opponent #"""+str(global.iter)+""" now.

There will be a total of 100 trials but only 1 trial is real.

Your winnings would be whatever you win in that Real trial.

If you lose in the Real trial, we won't take money from you.

You can rest anytime you like, get up, walk around, and question the experimenter."""
	if global.iter == 4:
		$"LineEdit".visible = false
		$"Button".visible = false
		if global.winnings > 0.0:
			$"RichTextLabel".text = """Thank you for participating.

Your one Real trial was Opponent #1 Trial #2.
 
You won $"""+str(global.winnings)+"""

Therefore, your bonus is $"""+str(global.winnings)+"""

Please contact the experimenter to receive your bonus."""
		if global.winnings < 0.0:
			$"RichTextLabel".text = """Thank you for participating.

Your one Real trial was Opponent #1 Trial #2.
 
You lost $"""+str(-1 * global.winnings)+"""

Therefore, you did not win any bonus."""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if global.iter == 0:
		global.participCode = $"LineEdit".text
	get_tree().change_scene("res://Main.tscn")
