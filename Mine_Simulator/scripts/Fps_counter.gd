extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.set_time_scale(1.0)
	Performance.get_monitor(Performance.TIME_FPS)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second())
