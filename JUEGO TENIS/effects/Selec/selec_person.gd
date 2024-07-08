extends Node2D
var Player : String ="res://Player.tscn"
var Player2 : String ="res://Player2.tscn"
var Player3 : String ="res://Player3.tscn"
var Player4 : String ="res://Player4.tscn"
var Player5 : String ="res://Player5.tscn"

func _ready():
	pass # Replace with function body.

func _on_Button_pressed():
	get_tree().change_scene("res://stage/Stage.tscn")# Replace with function body.


func _on_Button2_pressed():
	get_tree().change_scene("res://stage/Stage.tscn") # Replace with function body.


func _on_Button3_pressed():
	get_tree().change_scene("res://stage/Stage.tscn")# Replace with function body.


func _on_Button4_pressed():
	get_tree().change_scene("res://stage/Stage.tscn") # Replace with function body.


func _on_Button5_pressed():
	get_tree().change_scene("res://stage/Stage.tscn") # Replace with function body.
