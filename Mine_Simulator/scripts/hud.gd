extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global. sell_button_show:
		$sell_button.visible = true
	else:
		$sell_button.visible = false


func _on_sell_button_pressed() -> void:
	print("super mega op sell HUD is shows")
