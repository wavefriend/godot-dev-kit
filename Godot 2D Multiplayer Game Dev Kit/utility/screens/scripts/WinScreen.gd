extends Node2D


# stores reference to label that displays winner
onready var winner_label := $CanvasLayer/Control/CenterContainer/VBoxContainer/Winner


# called by ScreenManager to inform this class of who the winner was
# so that the winner can be displayed
func set_winner(winner:String):
	winner_label.text = winner + " won!"
