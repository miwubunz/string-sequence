extends Control

const LETTERS = [
	"letter",
	"godot",
	"dictionary",
	"array",
	"lolzers",
	"cat",
	"puppy",
	"uwu"
]

const TEXT_SIZE = Vector2(300, 80)
const GAP = 50

const DEFAULT_QUOTE = "guess the letter i'm thinking of :p"
const INCORRECT_QUOTES = [
	"[color=RED]nah, it ain't \"%s\"[/color]",
	"[color=RED]nope, it isn't \"%s\"[/color]",
	"[color=RED]nuh huh, \"%s\" is incorrect >:P[/color]"
]
const CORRECT_QUOTES = [
	"[color=GREEN]hmmm, yeah, yer doin' good[/color]",
	"[color=GREEN]mhm, correct...[/color]",
	"[color=GREEN]yus, you're doing good[/color]"
]

const MATCH_QUOTE = "HELL YEAH, i was thinking of \"%s\"! >:3"
const LABEL_INPUT = "your input: \"%s\""

func _ready() -> void:
	#var vp = get_viewport_rect().size
	var container = VBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.size.x = get_viewport_rect().size.x
	container.global_position.y = GAP
	#container.global_position.x = vp.x / 2 - TEXT_SIZE.x / 2

	var text = new_label(LABEL_INPUT % "")

	var hinter = new_label(DEFAULT_QUOTE)

	add_child(container)
	container.add_child(text)
	container.add_child(hinter)

	var sequencer = StringSequence.new(random_letter())
	add_child(sequencer)
	sequencer.incorrect_letter.connect(func(letter: int):
		hinter.text = INCORRECT_QUOTES.pick_random() % char(letter)
		text.text = LABEL_INPUT % ""
		)

	sequencer.correct_letter.connect(func(_letter: int, full_string: String, _foo: bool):
		hinter.text = CORRECT_QUOTES.pick_random()
		text.text = LABEL_INPUT % full_string
		)

	sequencer.sequence_matched.connect(func(string: String):
		hinter.text = MATCH_QUOTE % sequencer.string
		text.text = LABEL_INPUT % string
		sequencer.set_string(random_letter())
		)
	
	sequencer.input.connect(func(_letter: int, string: String, _s: bool):
		var sim = (-sequencer.get_string().similarity(string)) + 1
		text.modulate.g =  1.0
		text.modulate.r = sim
		text.modulate.b = sim
		)

func random_letter() -> String:
	return LETTERS.pick_random()

func new_label(content: String = "") -> RichTextLabel:
	var label = RichTextLabel.new()
	label.bbcode_enabled = true
	label.custom_minimum_size = TEXT_SIZE
	label.fit_content = true
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = content
	return label