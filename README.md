
# StringSequence

a very simple godot plugin that will keep track of what you type and emit signals based on whether it matches a sequence.

## usage

install the `addons` folder and paste it into your godot project, then, enable it in the project settings *(Project -> Project Settings -> Plugins)*

then, the `StringSequence` node will be available

you can assign a string to match with `set_string()`, and when you type it out properly, `matched_sequence` will be emitted

when you type a correct letter, `correct_letter` will be emitted *(`matched_sequence` will be true if the correct letter is the last one)*

when you type an incorrect letter, `incorrect_letter` will be emitted

and when there's any input, `input` will be emitted
