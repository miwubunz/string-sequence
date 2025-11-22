class_name StringSequence
extends Node

@export var string := ""
var _current_sequence := ""

signal sequence_matched(what: String)
signal correct_letter(letter: int, full_string: String, matched_sequence: bool)
signal incorrect_letter(letter: int)
signal input(letter: int, full_string: String, matched_sequence: bool)

func _input(event: InputEvent) -> void:
	if !string.is_empty():
		if event is InputEventKey:
			var t = event as InputEventKey
			if event.is_pressed() and !event.is_echo():
				var uc = t.unicode
				if uc:
					var val = char(uc)
					if string[_current_sequence.length()] == val:
						_current_sequence += val
						if _current_sequence.length() == string.length():
							correct_letter.emit(uc, string, true)
							sequence_matched.emit(string)
							input.emit(uc, string, true)
							_current_sequence = ""
						else:
							correct_letter.emit(uc, _current_sequence, false)
							input.emit(uc, _current_sequence, false)
					else:
						_current_sequence = ""
						incorrect_letter.emit(uc)
						input.emit(uc, _current_sequence, false)

func _init(what: String = "") -> void:
	string = what

func set_string(what: String) -> void:
	string = what

func get_string() -> String:
	return string

func get_current_sequence_string() -> String:
	return _current_sequence
