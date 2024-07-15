extends Node


signal room_escape_success

var has_begun : bool = false

var success_sfx = preload("res://sfx/success_sfx.mp3")
var fail_sfx = preload("res://sfx/fail_sfx.mp3")

var quiz_answer_set = {
	"민준-오전" : [["우드득", "모짜렐라", "묵은지니까", "인천아웃백"], "3 4 5 5"],
	"민준-오후" : [["3", "1", "5", "1"], "3 1 5 1"],
	"승일-오전" : [["고도리", "빌게이츠", "2", "오타와"], "9 1 5 7"],
	"승일-오후" : [["동일인물", "윤보선", "한종희", "캔버라"], "1 8 6 0"],
	"서아-오전" : [["홍길동전", "SEVEN", "9", "슈퍼마캣"], "4 7 9 4"],
	"서아-오후" : [["떡뽀끼", "마트", "3", "좀 비어서"], "3 2 3 4"],
	"은재-오전" : [["3", "4", "4", "1"], "1 4 2 7"],
	"은재-오후" : [["2", "이상혁", "4", "4"], "1 4 3 2"]
}

var quiz_owner

var quiz_answers = ["민준", "오전", "민준", "오전"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

