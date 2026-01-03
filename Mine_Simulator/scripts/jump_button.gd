extends TouchScreenButton

enum Anchor { TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, CENTER }

@export var anchor_point: Anchor = Anchor.BOTTOM_LEFT
@export var offset_from_edge := Vector2(150, 150)  # Отступ от края
@export var base_scale := 1.0

const BASE_HEIGHT = 648.0

func _ready():
	get_viewport().size_changed.connect(_update_position)
	_update_position()

func _update_position():
	var viewport_size = get_viewport().size
	var scale_factor = viewport_size.y / BASE_HEIGHT
	
	# Масштабируем кнопку
	scale = Vector2(scale_factor, scale_factor) * base_scale
	
	# Позиционируем в зависимости от якоря
	match anchor_point:
		Anchor.BOTTOM_LEFT:
			position = Vector2(
				offset_from_edge.x * scale_factor,
				viewport_size.y - offset_from_edge.y * scale_factor
			)
		Anchor.BOTTOM_RIGHT:
			position = Vector2(
				viewport_size.x - offset_from_edge.x * scale_factor,
				viewport_size.y - offset_from_edge.y * scale_factor
			)
		Anchor.TOP_LEFT:
			position = Vector2(
				offset_from_edge.x * scale_factor,
				offset_from_edge.y * scale_factor
			)
		Anchor.TOP_RIGHT:
			position = Vector2(
				viewport_size.x - offset_from_edge.x * scale_factor,
				offset_from_edge.y * scale_factor
			)
		Anchor.CENTER:
			position = viewport_size / 2.0
