extends MarginContainer


@onready var option_button = $VBoxContainer/HBoxContainer2/OptionButton
@onready var ui = get_node("/root/Main/CanvasLayer")
@onready var feedback_off_timer = $Timers/FeedbackOffTimer
@onready var time_recording_lable = $CanvasLayer/TimeRecordingLable
@onready var submit_button = $VBoxContainer/HBoxContainer2/SubmitButton
@onready var start_button = $VBoxContainer/HBoxContainer2/StartButton

var start_time


# Called when the node enters the scene tree for the first time.
func _ready():
	submit_button.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameManager.has_begun == true:
		start_button.disabled = true
		calculate_elapsed_time()
		
	
	if start_time == null:
		submit_button.disabled = true
	else:
		submit_button.disabled = false


func calculate_elapsed_time():
	var current_time = Time.get_unix_time_from_system()
	var elapsed_seconds = current_time - start_time

	var elapsed_minutes = int(elapsed_seconds / 60)
	elapsed_seconds = int(elapsed_seconds) % 60
	
	time_recording_lable.text = "경과시간: " + str(elapsed_minutes) + "분 " + str(elapsed_seconds) + "초" 



func _on_submit_button_pressed():
	var text_edit_nodes = get_tree().get_nodes_in_group("answer_input")
	var user_answer_array = []
	var answer_check_array = []
	
	feedback_off_timer.start() # Timer Start
	
	for text_edit_node in text_edit_nodes:
		user_answer_array.append(text_edit_node.text)
		
		
	for i in range(4):
		if GameManager.quiz_answers[i] == user_answer_array[i]:
			answer_check_array.append("정답")
		
		else:
			answer_check_array.append("오답")
	
	# print(answer_check_array)
			
	var label_nodes_array = get_tree().get_nodes_in_group("answer_check")
	
	for i in range(4):
		#if answer_check_array[i] == "정답":
			#label_nodes_array[i]["theme_override_colors/default_color"] = Color(0, 0, 255, 1)
		#else:
			#label_nodes_array[i]["theme_override_colors/default_color"] = Color(255, 0, 0, 1)
		label_nodes_array[i].text = answer_check_array[i]

	if "오답" not in answer_check_array:
		GameManager.room_escape_success.emit()

		visible = false
		ui.visible = true

func _on_option_button_item_selected(index):
	GameManager.quiz_owner = option_button.get_item_text(index)
	GameManager.quiz_answers = GameManager.quiz_answer_set[GameManager.quiz_owner][0]
	print(GameManager.quiz_answers)


func reset():
	GameManager.has_begun = false
	start_time = null
	var text_edit_nodes = get_tree().get_nodes_in_group("answer_input")
	for text_node in text_edit_nodes:
		text_node.text = ""
	
	var label_nodes_array = get_tree().get_nodes_in_group("answer_check")
	for label_node in label_nodes_array:
		label_node.text = ""
		
	start_button.disabled = false
	


func _on_start_button_pressed():
	GameManager.has_begun = true
	getting_start_time()
	


func _on_feedback_off_timer_timeout():
	var label_nodes_array = get_tree().get_nodes_in_group("answer_check")
	for label in label_nodes_array:
		label.text = ""
		
		
func getting_start_time():
	start_time = Time.get_unix_time_from_system()
