extends VBoxContainer

############################## NOTES ##############################

# add up to 8 audio players as children

# QueueLabelBox item must be added to theme
# font_color_i where i = 0,1,2,...7
# separation
# show_duration
# fade_duration
# max_label_count
# font
# label_normal

############################## ONREADYS ##############################

onready var sfx := []

############################## VARIABLES ##############################

var font_colors := []

var show_duration := 1.0
var fade_duration := 0.1 # must be less than show duration
var max_label_count := 16

var font : Font = null

var label_stylebox : StyleBox = null

############################## INIT ##############################

func _ready():
	# theme colors
	font_colors.append(get_color("font_color_0", "QueueLabelBox"))
	font_colors.append(get_color("font_color_1", "QueueLabelBox"))
	font_colors.append(get_color("font_color_2", "QueueLabelBox"))
	font_colors.append(get_color("font_color_3", "QueueLabelBox"))
	font_colors.append(get_color("font_color_4", "QueueLabelBox"))
	font_colors.append(get_color("font_color_5", "QueueLabelBox"))
	font_colors.append(get_color("font_color_6", "QueueLabelBox"))
	font_colors.append(get_color("font_color_7", "QueueLabelBox"))
	
	# theme constants
	set("custom_constants/separation", get_constant("separation", "QueueLabelBox"))
	show_duration = get_constant("show_duration", "QueueLabelBox")
	fade_duration = get_constant("fade_duration", "QueueLabelBox")
	max_label_count = get_constant("max_label_count", "QueueLabelBox")
	
	# theme fonts
	font = get_font("font", "QueueLabelBox")
	
	# theme styleboxes
	label_stylebox = get_stylebox("label_normal", "QueueLabelBox")

############################## QUEUE LABELS ##############################

# queues up text
func queue_text(text:String, preset:=0):
	# remove first label(s) if new label would be over max label count
	var remove_count := max(get_child_count() - max_label_count, 0)
	for i in range(remove_count):
		get_child(i).call_deferred("queue_free")
	
	# create label
	var label := Label.new()
	label.text = text
	label.align = ALIGN_CENTER
	label.size_flags_horizontal = SIZE_SHRINK_CENTER
	label.set("custom_colors/font_color", font_colors[preset])
	label.set("custom_fonts/font", font)
	label.set("custom_styles/normal", label_stylebox)
	
	# create timer
	var timer := Timer.new()
	timer.wait_time = show_duration
	timer.autostart = true
	timer.one_shot = true
	timer.connect("timeout", self, "_timeout", [label])
	
	# play a sound if there is one to play
	if preset < len(sfx):
		sfx[preset].play()
	
	# add label and timer children
	call_deferred("add_child", label)
	label.call_deferred("add_child", timer)


# called when a timer runs out
func _timeout(label:Label):
	label.call_deferred("queue_free")

############################## PROCESS ##############################

func _process(_delta:float):
	for label in get_children():
		var time_left : float = label.get_child(0).time_left
		var alpha := time_left / fade_duration if (time_left < fade_duration) else 1.0
		label.modulate = Color(1,1,1,alpha)

############################## END ##############################


