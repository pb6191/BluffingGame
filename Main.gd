extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng2 = RandomNumberGenerator.new()
var rng3 = RandomNumberGenerator.new()
var rng4 = RandomNumberGenerator.new()
var rng5 = RandomNumberGenerator.new()
var oppBet = 30.0
var oppRaise = 50.0
var bet = 10.0
var raise = 50.0
var money = 0.0
var moneyStr = "Your total winnings: $"
var moneyStrOpp = "Opponent total winnings: $"
var trialNum = 1
var totalTrials = 3
var freshPress = false
var freshPressRight = false
var leftButtonText1 = "Bet $10"
var leftButtonText2 = "Waiting for opponent to bet"
var leftButtonText3 = "DEAL!"
var leftButtonText3b = "Pick up the cards from the table"
var leftButtonText4 = "Do you want to raise $50?"
var rightButtonText4 = "Do you want to fold?"
var leftButtonText5 = "Waiting for opponent to raise or fold"
var leftButtonText6 = "Show the cards to the opponent"
var leftButtonText7 = "Next round (Deal new cards on table)"
var leftButtonTextEnd = "Main Menu"
var timeButton1stFreeze
var timeButton1stFreezeMax
var timeButton2ndFreeze
var timeButton2ndFreezeMax
var cardSelectedPos
var cardSelectedVal
var opponentDecision
var opponentRaisingProbOutOf9
var cardarray = ["res://PNG-cards/10_of_clubs.png", "res://PNG-cards/10_of_diamonds.png", "res://PNG-cards/10_of_hearts.png", "res://PNG-cards/10_of_spades.png", "res://PNG-cards/2_of_clubs.png", "res://PNG-cards/2_of_diamonds.png", "res://PNG-cards/2_of_hearts.png", "res://PNG-cards/2_of_spades.png", "res://PNG-cards/3_of_clubs.png", "res://PNG-cards/3_of_diamonds.png", "res://PNG-cards/3_of_hearts.png", "res://PNG-cards/3_of_spades.png", "res://PNG-cards/4_of_clubs.png", "res://PNG-cards/4_of_diamonds.png", "res://PNG-cards/4_of_hearts.png", "res://PNG-cards/4_of_spades.png", "res://PNG-cards/5_of_clubs.png", "res://PNG-cards/5_of_diamonds.png", "res://PNG-cards/5_of_hearts.png", "res://PNG-cards/5_of_spades.png", "res://PNG-cards/6_of_clubs.png", "res://PNG-cards/6_of_diamonds.png", "res://PNG-cards/6_of_hearts.png", "res://PNG-cards/6_of_spades.png", "res://PNG-cards/7_of_clubs.png", "res://PNG-cards/7_of_diamonds.png", "res://PNG-cards/7_of_hearts.png", "res://PNG-cards/7_of_spades.png", "res://PNG-cards/8_of_clubs.png", "res://PNG-cards/8_of_diamonds.png", "res://PNG-cards/8_of_hearts.png", "res://PNG-cards/8_of_spades.png", "res://PNG-cards/9_of_clubs.png", "res://PNG-cards/9_of_diamonds.png", "res://PNG-cards/9_of_hearts.png", "res://PNG-cards/9_of_spades.png", "res://PNG-cards/ace_of_clubs.png", "res://PNG-cards/ace_of_diamonds.png", "res://PNG-cards/ace_of_hearts.png", "res://PNG-cards/ace_of_spades.png", "res://PNG-cards/ace_of_spades2.png", "res://PNG-cards/black_joker.png", "res://PNG-cards/jack_of_clubs.png", "res://PNG-cards/jack_of_clubs2.png", "res://PNG-cards/jack_of_diamonds.png", "res://PNG-cards/jack_of_diamonds2.png", "res://PNG-cards/jack_of_hearts.png", "res://PNG-cards/jack_of_hearts2.png", "res://PNG-cards/jack_of_spades.png", "res://PNG-cards/jack_of_spades2.png", "res://PNG-cards/king_of_clubs.png", "res://PNG-cards/king_of_clubs2.png", "res://PNG-cards/king_of_diamonds.png", "res://PNG-cards/king_of_diamonds2.png", "res://PNG-cards/king_of_hearts.png", "res://PNG-cards/king_of_hearts2.png", "res://PNG-cards/king_of_spades.png", "res://PNG-cards/king_of_spades2.png", "res://PNG-cards/queen_of_clubs.png", "res://PNG-cards/queen_of_clubs2.png", "res://PNG-cards/queen_of_diamonds.png", "res://PNG-cards/queen_of_diamonds2.png", "res://PNG-cards/queen_of_hearts.png", "res://PNG-cards/queen_of_hearts2.png", "res://PNG-cards/queen_of_spades.png", "res://PNG-cards/queen_of_spades2.png", "res://PNG-cards/red_joker.png"]
var carditem

# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use
# change all the randomizers to use random num generator and randomize the seed before each use


# Called when the node enters the scene tree for the first time.
func _ready():
	opponentRaisingProbOutOf9 = global.raiseProb[global.iter-1]
	$"TextRound".text = "Round "+str(trialNum)
	$"PlayerLeft10".visible = true
	updateMoney(0)
	$"ButtonLeft".disabled = true
	$"OppLeft10".visible = true
	$"TextInstr".text = "You ante'd $"+str(bet)+". Your opponent ante'd $"+str(oppBet) + ". Now, you can see the cards. Don't worry! Your opponent won't be able to see them"
	if (global.iter == 1 and (global.oppPicOrder == 1 or global.oppPicOrder == 2)) or (global.iter == 2 and (global.oppPicOrder == 3 or global.oppPicOrder == 5)) or (global.iter == 3 and (global.oppPicOrder == 4 or global.oppPicOrder == 6)):
		$"OppPic1".visible = true
	elif (global.iter == 1 and (global.oppPicOrder == 3 or global.oppPicOrder == 4)) or (global.iter == 2 and (global.oppPicOrder == 1 or global.oppPicOrder == 6)) or (global.iter == 3 and (global.oppPicOrder == 2 or global.oppPicOrder == 5)):
		$"OppPic2".visible = true
	elif (global.iter == 1 and (global.oppPicOrder == 5 or global.oppPicOrder == 6)) or (global.iter == 2 and (global.oppPicOrder == 2 or global.oppPicOrder == 4)) or (global.iter == 3 and (global.oppPicOrder == 1 or global.oppPicOrder == 3)):
		$"OppPic3".visible = true
	$"ButtonLeft".text = leftButtonText3


func setNonKing():
	cardarray.shuffle()
	carditem = cardarray[0]
	while "king" in carditem or "ace" in carditem:
		cardarray.shuffle()
		carditem = cardarray[0]

func setKing():
	cardarray.shuffle()
	carditem = cardarray[0]
	while !("king" in carditem):
		cardarray.shuffle()
		carditem = cardarray[0]
	var whichONE = [1, 2, 3, 4, 5]
	whichONE.shuffle()
	if whichONE[0] == 1:
		$"C1".texture = load(carditem)
	if whichONE[0] == 2:
		$"C2".texture = load(carditem)
	if whichONE[0] == 3:
		$"C3".texture = load(carditem)
	if whichONE[0] == 4:
		$"C4".texture = load(carditem)
	if whichONE[0] == 5:
		$"C5".texture = load(carditem)

func cardChoice():
	rng2.randomize()
	# 5/6th prob of getting a 2
	var getZeroOne = rng2.randi_range(1,6)
	if (getZeroOne) == 1:
		cardSelectedVal = "ace"
		#$"Ace".visible = true
		setNonKing()
		$"C1".texture = load(carditem)
		$"C1".visible = true
		setNonKing()
		$"C2".texture = load(carditem)
		$"C2".visible = true
		setNonKing()
		$"C3".texture = load(carditem)
		$"C3".visible = true
		setNonKing()
		$"C4".texture = load(carditem)
		$"C4".visible = true
		setNonKing()
		$"C5".texture = load(carditem)
		$"C5".visible = true
		setKing()
	else:
		cardSelectedVal = "two"
		#$"TwoSpades".visible = true
		setNonKing()
		$"C1".texture = load(carditem)
		$"C1".visible = true
		setNonKing()
		$"C2".texture = load(carditem)
		$"C2".visible = true
		setNonKing()
		$"C3".texture = load(carditem)
		$"C3".visible = true
		setNonKing()
		$"C4".texture = load(carditem)
		$"C4".visible = true
		setNonKing()
		$"C5".texture = load(carditem)
		$"C5".visible = true
	$"ButtonLeft".disabled = false
	#$"ButtonLeft".text = leftButtonText3b
	$"ButtonRight".visible = true
	$"LeftCardBack".visible = false
	$"ButtonLeft".text = leftButtonText4
	$"ButtonRight".text = rightButtonText4


func updateMoney(amt):
	money += amt
	$"TextAmt".text = moneyStr + str(money)
	$"TextAmtOpp".text = moneyStrOpp + str(-money)

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
		updateMoney(0)
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

	if ($"ButtonLeft".text == leftButtonText3b and freshPress == true):
		freshPress = false
		#$"Ace".visible = false
		#$"TwoSpades".visible = false
		$"C1".visible = false
		$"C2".visible = false
		$"C3".visible = false
		$"C4".visible = false
		$"C5".visible = false
		$"ButtonRight".visible = true
		$"LeftCardBack".visible = false
		if global.iter == 0:
			$"TextInstr".text = "You picked up the cards from the table and they are in your hands now and only you can see them. Now you have to decide whether to up your bet by raising more money or to fold and let your opponent win all the money on the table"
		else:
			$"TextInstr".text = "You picked up the cards from the table and only you can see them. Now you have to decide whether to up your bet by raising more money or to fold"
		$"ButtonRight".text = rightButtonText4
		$"ButtonLeft".text = leftButtonText4
	if ($"ButtonLeft".text == leftButtonText4 and freshPress == true):
		freshPress = false
		
		$"C1".visible = false
		$"C2".visible = false
		$"C3".visible = false
		$"C4".visible = false
		$"C5".visible = false
		
		$"PlayerRight10".visible = true
		$"ButtonRight".visible = false
		updateMoney(0)
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
			if global.iter == 0:
				$"TextInstr".text = "You have chosen to up the ante by raising more money. Smart move, you have a King! Now, we are waiting for your opponent to fold or increase their bet"
			else:
				$"TextInstr".text = "We are waiting for your opponent to fold or increase their bet"
		else:
			if global.iter == 0:
				$"TextInstr".text = "Aha! You have chosen to up the ante by raising more money and we are a go for the bluff. Now, we are waiting for your opponent to fold or increase their bet"
			else:
				$"TextInstr".text = "We are waiting for your opponent to fold or increase their bet"
		$"ButtonLeft".text = leftButtonText5
	if ($"ButtonLeft".text == leftButtonText5 and freshPress == true):
		freshPress = false
		# refer the process if else stmt
		$"ButtonLeft".text = leftButtonText6
	if ($"ButtonLeft".text == leftButtonText6 and freshPress == true):
		freshPress = false
		if cardSelectedVal == "ace":
			if global.iter == 0:
				$"TextInstr".text = "You just placed your cards on the table, face up and grabbed all the money off the table. Congrats, you won $"+str(oppBet)+" ante and $"+str(oppRaise)+" raise from your opponent. You also keep your $"+str(bet)+" ante and your $"+str(raise)+" raise."
			else:
				$"TextInstr".text = "Congrats, you won $"+str(oppBet)+" ante and $"+str(oppRaise)+" raise from your opponent. You also keep your $"+str(bet)+" ante and your $"+str(raise)+" raise."
			$"WINlogo".visible = true
			$"WINPlayer".play()
			updateMoney(oppBet+oppRaise)
			#$"LeftAce".visible = true
			#$"Ace".visible = true
			$"C1".visible = true
			$"C2".visible = true
			$"C3".visible = true
			$"C4".visible = true
			$"C5".visible = true
		else:
			if global.iter == 0:
				$"TextInstr".text = "You just placed you cards on the table, face up and your opponent grabbed all the money off the table. Sorry, you lost your $"+str(bet)+" ante and your $"+str(raise)+" raise."
			else:
				$"TextInstr".text = "Sorry, you lost your $"+str(bet)+" ante and your $"+str(raise)+" raise."
			$"LOSElogo".visible = true
			$"LOSEPlayer".play()
			updateMoney(-bet-raise)
			#$"LeftTwoSpades".visible = true
			#$"TwoSpades".visible = true
			$"C1".visible = true
			$"C2".visible = true
			$"C3".visible = true
			$"C4".visible = true
			$"C5".visible = true
		$"OppLeft10".visible = false
		$"OppRight10".visible = false
		$"PlayerLeft10".visible = false
		$"PlayerRight10".visible = false
		endTrial()
	if ($"ButtonLeft".text == leftButtonText7 and freshPress == true):
		freshPress = false
		$"LeftCardBack".visible = true
		#$"LeftAce".visible = false
		#$"Ace".visible = false
		#$"LeftTwoSpades".visible = false
		#$"TwoSpades".visible = false
		$"C1".visible = false
		$"C2".visible = false
		$"C3".visible = false
		$"C4".visible = false
		$"C5".visible = false
		$"TextRound".text = "Round "+str(trialNum)
		$"TextInstr".text = "Fresh round begins with new cards dealt on the table. You ante'd $"+str(bet)+". Your opponent ante'd $"+str(oppBet) + ". Now, you can see the cards. Don't worry! Your opponent won't be able to see them"
		$"PlayerLeft10".visible = true
		updateMoney(0)
		$"ButtonLeft".disabled = true
		$"OppLeft10".visible = true
		$"WINlogo".visible = false
		$"LOSElogo".visible = false
		$"ButtonLeft".text = leftButtonText3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"ButtonLeft".text == leftButtonText2:
		timeButton1stFreeze += delta
		if timeButton1stFreeze > timeButton1stFreezeMax:
			$"OppLeft10".visible = true
			$"TextInstr".text = "Your opponent has placed a bet of $"+str(oppBet) + ". Now, you can see the cards. Don't worry! Your opponent won't be able to see them"
			$"ButtonLeft".text = leftButtonText3
	if $"ButtonLeft".text == leftButtonText5:
		timeButton2ndFreeze += delta
		if timeButton2ndFreeze > timeButton2ndFreezeMax:
			if opponentDecision == "raise":
				$"OppRight10".visible = true
				$"ButtonLeft".disabled = false
				$"ButtonRight".visible = false
				if cardSelectedVal == "ace":
					if global.iter == 0:
						$"TextInstr".text = "Your opponent decided to increase their bet. You will have to show your cards now. But you have nothing to worry about since you have a King"
					else:
						$"TextInstr".text = "Your opponent decided to increase their bet. You have to show your cards now"
				else:
					if global.iter == 0:
						$"TextInstr".text = "Your opponent decided to increase their bet. You will have to show your losing hand now. Sorry about that"
					else:
						$"TextInstr".text = "Your opponent decided to increase their bet. You have to show your cards now"
				$"ButtonLeft".text = leftButtonText6
			else:
				updateMoney(oppBet)
				$"OppLeft10".visible = false
				$"PlayerLeft10".visible = false
				$"PlayerRight10".visible = false
				$"ButtonLeft".disabled = false
				$"ButtonRight".visible = false
				if cardSelectedVal == "ace":
					if global.iter == 0:
						$"TextInstr".text = "Your opponent decided to fold. You won $"+str(oppBet)+" from your opponent and you get back your $"+str(bet)+" ante and $"+str(raise)+" raise. You missed out on winning more bet money from your opponent though"
					else:
						$"TextInstr".text = "Your opponent folded. You won $"+str(oppBet)+" from your opponent and you get back your $"+str(bet)+" ante and $"+str(raise)+" raise."
				else:
					if global.iter == 0:
						$"TextInstr".text = "Your opponent decided to fold. Haha! Looks like the bluff worked. You won $"+str(oppBet)+" from your opponent and you get back your $"+str(bet)+" ante and $"+str(raise)+" raise."
					else:
						$"TextInstr".text = "Your opponent folded. You won $"+str(oppBet)+" from your opponent and you get back your $"+str(bet)+" ante and $"+str(raise)+" raise."
				$"WINlogo".visible = true
				$"WINPlayer".play()
				endTrial()

func _on_ButtonLeft_button_down():
	freshPress = true


func _on_LeftCardBack_gui_input(event):
	if event.is_action("lftclk") and $"ButtonLeft".text == leftButtonText3:
		cardSelectedPos = "left"
		$"TextInstr".text = "You have seen the cards. Don't worry! This is just a sneak peek, your opponent doesn't know what the cards are. Now you have to decide whether to up your bet by raising more money or to fold"
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
		updateMoney(-bet)
		if cardSelectedVal == "ace":
			if global.iter == 0:
				$"TextInstr".text = "Seems like you just folded despite having an ace. Is that some kind of complex strategy? You lost your $"+str(bet)+" ante."
			else:
				$"TextInstr".text = "You folded and showed your cards to the opponent. You lost your $"+str(bet)+" ante."
			#$"LeftAce".visible = true
			#$"Ace".visible = true
			$"C1".visible = true
			$"C2".visible = true
			$"C3".visible = true
			$"C4".visible = true
			$"C5".visible = true
		else:
			if global.iter == 0:
				$"TextInstr".text = "Seems like you just folded your losing hand. I guess we are not bluffing today, huh? You lost your $"+str(bet)+" ante."
			else:
				$"TextInstr".text = "You folded and showed your cards to the opponent. You lost your $"+str(bet)+" ante."
			#$"LeftTwoSpades".visible = true
			#$"TwoSpades".visible = true
			$"C1".visible = true
			$"C2".visible = true
			$"C3".visible = true
			$"C4".visible = true
			$"C5".visible = true
		$"LOSElogo".visible = true
		$"LOSEPlayer".play()
		endTrial()


func _on_ButtonRight_button_down():
	freshPressRight = true
