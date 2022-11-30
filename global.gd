extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var winnings
var participCode

var iter = 0 # 0 is training 1, 2, 3 are the three opponents
var raiseProb = [5, 9, 0]
var oppPicOrder = randi()%6+1 # a random number from 1 to 6
# 1 is 123
# 2 is 132
# 3 is 213
# 4 is 231
# 5 is 312
# 6 is 321

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
