extends Control

signal resest_requested

@onready var ui = get_node("CanvasLayer")
@onready var game_panel = $GamePanel
@onready var game_scene = $GamePanel/GameScene
@onready var final_password_label = $CanvasLayer/FinalPasswordLabel
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _ready():
	resest_requested.connect(on_resest_requested)
	GameManager.room_escape_success.connect(on_room_escape_success)
	ui.visible = false


func on_room_escape_success():
	GameManager.has_begun = false
	game_panel.get_child(0).visible = false
	ui.visible = true
	final_password_label.text = GameManager.quiz_answer_set[GameManager.quiz_owner][1]
	audio_stream_player_2d.stream = GameManager.success_sfx
	audio_stream_player_2d.play()
	await(audio_stream_player_2d.finished)



func _on_button_pressed():
	resest_requested.emit()


func on_resest_requested():
	get_tree().paused = false
	ui.visible = false
	game_panel.get_child(0).visible = true
	game_scene.reset()
