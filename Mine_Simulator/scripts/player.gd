extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 6.0
const GRAVITY_JUMP_MULTIPLAYER = 1.4

@onready var camera = get_node_or_null("Camera3D")
var rotation_y: float = 0.0
var rotation_x: float = 0.0
@export var sensitivity: float = 0.5
@export var min_pitch: float = -80.0
@export var max_pitch: float = 80.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_JUMP_MULTIPLAYER
	# Handle jump.
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		# Получаем относительное движение пальца
		var drag_delta = event.relative
		
		# Поворот по горизонтали (Y-ось)
		rotation_y -= drag_delta.x * sensitivity * 0.01
		
		# Поворот по вертикали (X-ось)
		rotation_x -= drag_delta.y * sensitivity * 0.01
		
		# Ограничиваем вертикальный угол
		rotation_x = clamp(rotation_x, deg_to_rad(min_pitch), deg_to_rad(max_pitch))
		
		# Применяем вращение
		rotation.y = rotation_y
		camera.rotation.x = rotation_x
