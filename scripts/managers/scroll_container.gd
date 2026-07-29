extends ScrollContainer

var tween: Tween
var target_scroll := 0.0

func _ready():
	print(get_h_scroll_bar().max_value)
	target_scroll = scroll_horizontal

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			target_scroll = min(target_scroll + 400, get_h_scroll_bar().max_value)
			smooth_scroll()
			accept_event()

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			target_scroll = max(target_scroll - 400, 0)
			smooth_scroll()
			accept_event()

func smooth_scroll():
	var max_scroll = get_h_scroll_bar().max_value
	target_scroll = clamp(target_scroll, 0, max_scroll)

	if tween and tween.is_running():
		tween.kill()

	#if scroll_horizontal == 0 or scroll_horizontal == max_scroll:
		#target_scroll = scroll_horizontal
		
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
	self,
	"scroll_horizontal",
	target_scroll,
	0.5
)
