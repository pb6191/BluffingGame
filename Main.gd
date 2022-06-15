extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng2 = RandomNumberGenerator.new()
var rng3 = RandomNumberGenerator.new()
var rng4 = RandomNumberGenerator.new()
var rng5 = RandomNumberGenerator.new()
var oppBet = 10.0
var oppRaise = 10.0
var bet = 10.0
var raise = 10.0
var money = 100.0
var moneyStr = "Money you have in pocket: $"
var trialNum = 1
var totalTrials = 2
var freshPress = false
var freshPressRight = false
var leftButtonText1 = "Bet $10"
var leftButtonText2 = "Waiting for opponent to bet"
var leftButtonText3 = "Sneak peek the card by clicking on it"
var leftButtonText3b = "Pick up the card from the table"
var leftButtonText4 = "Raise $10"
var rightButtonText4 = "Fold and show card to the opponent"
var leftButtonText5 = "Waiting for opponent to raise or fold"
var leftButtonText6 = "Show the card to the opponent"
var leftButtonText7 = "Next round (Deal a new card on table)"
var leftButtonTextEnd = "Main Menu"
var timeButton1stFreeze
var timeButton1stFreezeMax
var timeButton2ndFreeze
var timeButton2ndFreezeMax
var cardSelectedPos
var cardSelectedVal
var opponentDecision
var opponentRaisingProbOutOf9

# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use


# Called when the node enters the scene tree for the first time.
func _ready():
	opponentRaisingProbOutOf9 = global.raiseProb[global.iter-1]
	$"ButtonLeft".text = leftButtonText1
	$"TextRound".text = "Round "+str(trialNum)
	$"TextInstr".text = "You have to place a bet to begin"
	updateMoney(0.0)

func cardChoice():
	rng2.randomize()
	# 5/6th prob of getting a 2
	var getZeroOne = rng2.randi_range(1,6)
	if (getZeroOne) == 1:
		cardSelectedVal = "ace"
		$"Ace".visible = true
	else:
		cardSelectedVal = "two"
		$"TwoSpades".visible = true
	$"ButtonLeft".disabled = false
	$"ButtonLeft".text = leftButtonText3b

func updateMoney(amt):
	money += amt
	$"TextAmt".text = moneyStr + str(money)

func endTrial():
	trialNum += 1
	if trialNum == totalTrials+1:
		$"ButtonLeft".text = leftButtonTextEnd
	else:
		$"ButtonLeft".text = leftButtonText7

func _on_ButtonLeft_pressed():
	if ($"ButtonLeft".text == leftButtonTextEnd and freshPress == true):
		freshPress = false
		global.iter += 1
		get_tree().change_scene("res://Start.tscn")
	if ($"ButtonLeft".text == leftButtonText1 and freshPress == true):
		freshPress = false
		$"PlayerLeft10".visible = true
		updateMoney(-bet)
		$"ButtonLeft".disabled = true
		timeButton1stFreeze = 0.0
		rng3.randomize()
		timeButton1stFreezeMax = rng3.randi_range(4,6) # 4 to 6 secs
		$"TextInstr".text = "We are just waiting for your opponent to place their bet"
		$"ButtonLeft".text = leftButtonText2
	if ($"ButtonLeft".text == leftButtonText2 and freshPress == true):
		freshPress = false
		# refer the process if else stmt
		$"ButtonLeft".text = leftButtonText3
	if ($"ButtonLeft".text == leftButtonText3 and freshPress == true):
		freshPress = false
		# refer the card back click functions
		$"ButtonLeft".text = leftButtonText3b
	if ($"ButtonLeft".text == leftButtonText3b and freshPress == true):
		freshPress = false
		$"Ace".visible = false
		$"TwoSpades".visible = false
		$"ButtonRight".visible = true
		$"LeftCardBack".visible = false
		#$"TextInstr".text = "You picked up the card from the table and it is in your hands now and only you can see it. Now you have to decide whether to up your bet by raising more money or to fold and let your opponent win all the money on the table"
		$"TextInstr".text = "You picked up the card from the table and only you can see it. Now you have to decide whether to up your bet by raising more money or to fold"
		$"ButtonRight".text = rightButtonText4
		$"ButtonLeft".text = leftButtonText4
	if ($"ButtonLeft".text == leftButtonText4 and freshPress == true):
		freshPress = false
		$"PlayerRight10".visible = true
		$"ButtonRight".visible = false
		updateMoney(-raise)
		$"ButtonLeft".disabled = true
		timeButton2ndFreeze = 0.0
		rng4.randomize()
		timeButton2ndFreezeMax = rng4.randi_range(6,9) # 6 to 9 secs
		rng5.randomize()
		var getZeroOne = rng5.randi_range(1,9)
		if (getZeroOne) <= opponentRaisingProbOutOf9:
			opponentDecision = "raise"
		else:
			opponentDecision = "fold"
		if cardSelectedVal == "ace":
			#$"TextInstr".text = "You have chosen to up the ante by raising more money. Smart move, you have a King! Now, we are waiting for your opponent to fold or increase their bet"
			$"TextInstr".text = "We are waiting for your opponent to fold or increase their bet"
		else:
			#$"TextInstr".text = "Aha! You have chosen to up the ante by raising more money and we are a go for the bluff. Now, we are waiting for your opponent to fold or increase their bet"
			$"TextInstr".text = "We are waiting for your opponent to fold or increase their bet"
		$"ButtonLeft".text = leftButtonText5
	if ($"ButtonLeft".text == leftButtonText5 and freshPress == true):
		freshPress = false
		# refer the process if else stmt
		$"ButtonLeft".text = leftButtonText6
	if ($"ButtonLeft".text == leftButtonText6 and freshPress == true):
		freshPress = false
		if cardSelectedVal == "ace":
			#$"TextInstr".text = "You just placed you card on the table, face up and grabbed all the money off the table. Congrats, you got your bet and raise back and won your opponents first and subsequent bet money"
			$"TextInstr".text = "Congrats, you won"
			updateMoney(bet+raise+oppBet+oppRaise)
			$"LeftAce".visible = true
		else:
			#$"TextInstr".text = "You just placed you card on the table, face up and your opponent grabbed all the money off the table. Sorry, your opponent won your bet and raise money and kept what they had bet"
			$"TextInstr".text = "Sorry, you lost"
			$"LeftTwoSpades".visible = true
		$"OppLeft10".visible = false
		$"OppRight10".visible = false
		$"PlayerLeft10".visible = false
		$"PlayerRight10".visible = false
		endTrial()
	if ($"ButtonLeft".text == leftButtonText7 and freshPress == true):
		freshPress = false
		$"LeftCardBack".visible = true
		$"LeftAce".visible = false
		$"LeftTwoSpades".visible = false
		$"TextRound".text = "Round "+str(trialNum)
		$"TextInstr".text = "Fresh round begins with a new card dealt on the table. Best of luck. You have to place a bet to begin"
		$"ButtonLeft".text = leftButtonText1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"ButtonLeft".text == leftButtonText2:
		timeButton1stFreeze += delta
		if timeButton1stFreeze > timeButton1stFreezeMax:
			$"OppLeft10".visible = true
			$"TextInstr".text = "Your opponent has placed a bet of $"+str(oppBet) + ". Now, you can see the card. Don't worry! Your opponent won't be able to see it"
			$"ButtonLeft".text = leftButtonText3
	if $"ButtonLeft".text == leftButtonText5:
		timeButton2ndFreeze += delta
		if timeButton2ndFreeze > timeButton2ndFreezeMax:
			if opponentDecision == "raise":
				$"OppRight10".visible = true
				$"ButtonLeft".disabled = false
				$"ButtonRight".visible = false
				if cardSelectedVal == "ace":
					#$"TextInstr".text = "Your opponent decided to increase their bet. You will have to show your card now. But you have nothing to worry about since you had a King"
					$"TextInstr".text = "Your opponent decided to increase their bet. You have to show your card now"
				else:
					#$"TextInstr".text = "Your opponent decided to increase their bet. You will have to show your 2 of spades card now. Sorry about that"
					$"TextInstr".text = "Your opponent decided to increase their bet. You have to show your card now"
				$"ButtonLeft".text = leftButtonText6
			else:
				updateMoney(bet+raise+oppBet)
				$"OppLeft10".visible = false
				$"PlayerLeft10".visible = false
				$"PlayerRight10".visible = false
				$"ButtonLeft".disabled = false
				$"ButtonRight".visible = false
				if cardSelectedVal == "ace":
					#$"TextInstr".text = "Your opponent decided to fold. You will get your bet and raise back and you also win what your opponent had betted. You missed out on winning more bet money from your opponent though"
					$"TextInstr".text = "Your opponent folded"
				else:
					#$"TextInstr".text = "Your opponent decided to fold. Haha! Looks like the bluff worked. You will get your bet and raise back and you also win what your opponent had betted"
					$"TextInstr".text = "Your opponent folded"
				endTrial()

func _on_ButtonLeft_button_down():
	freshPress = true


func _on_LeftCardBack_gui_input(event):
	if event.is_action("lftclk") and $"ButtonLeft".text == leftButtonText3:
		cardSelectedPos = "left"
		$"TextInstr".text = "You have seen the card. Don't worry! This is just a sneak peek, your opponent doesn't know what this card is"
		cardChoice()


func _on_RightCardBack_gui_input(event):
	pass
#	if event.is_action("lftclk") and $"ButtonLeft".text == leftButtonText3:
#		cardSelectedPos = "right"
#		$"TextInstr".text = "You have selected the card on the right. Don't worry! This is just a sneak peek, your opponent doesn't know what this card is"
#		cardChoice()


func _on_ButtonRight_pressed():
	if ($"ButtonRight".text == rightButtonText4 and freshPressRight == true):
		freshPressRight = false
		$"ButtonRight".visible = false
		$"PlayerLeft10".visible = false
		$"OppLeft10".visible = false
		if cardSelectedVal == "ace":
			#$"TextInstr".text = "Seems like you just folded despite having an ace. Is that some kind of complex strategy?"
			$"TextInstr".text = "You folded and showed your card to the opponent"
			$"LeftAce".visible = true
		else:
			#$"TextInstr".text = "Seems like you just folded your 2 of spades. I guess we are not bluffing today, huh?"
			$"TextInstr".text = "You folded and showed your card to the opponent"
			$"LeftTwoSpades".visible = true
		endTrial()


func _on_ButtonRight_button_down():
	freshPressRight = true
