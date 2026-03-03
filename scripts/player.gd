extends CharacterBody2D


const WATER_SPEED = 160.0
const WATER_ACCELERATION = 240.0
const WATER_GRAVITY = Vector2(0, 1) * 600

const SURFACE_SPEED = 80.0
const SURFACE_ACCELERATION = 240.0
const JUMP_VELOCITY = -140.0

var water_momentum = Vector2.ZERO

var underwater_mode = false
var just_surfaced = false

const LIGHT_SWITCH_SPEED = 1.5;
const LIGHT_SIZE_SURFACE = 0.2
const LIGHT_SIZE_UNDERWATER = 0.1
var light_size = LIGHT_SIZE_SURFACE;

var oxygen = 0.0
var max_oxygen = 30.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var color_rect: ColorRect = $ColorRect
@onready var color_rect_2: ColorRect = $ColorRect2


func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	if underwater_mode:
		movement_underwater(delta, input_vector)
	else:
		movement_overwater(delta, input_vector)
	if input_vector.x != 0.0:
		sprite_2d.flip_h = input_vector.x < 0.0
	color_rect_2.material.set_shader_parameter("oxygen", oxygen / max_oxygen)
	color_rect.material.set_shader_parameter("radius", light_size)
	move_and_slide()

func movement_overwater(delta, input_vector):
	velocity.x = move_toward(velocity.x, input_vector.x * SURFACE_SPEED, SURFACE_ACCELERATION * delta)
	if is_on_floor() and input_vector.y < 0 or just_surfaced:
		velocity.y += JUMP_VELOCITY
	else:
		velocity += WATER_GRAVITY * delta
	water_momentum = velocity
	
	oxygen = 0.0
	
	light_size = move_toward(light_size, LIGHT_SIZE_SURFACE, (LIGHT_SWITCH_SPEED * abs(light_size - LIGHT_SIZE_SURFACE)) * delta)
	
	just_surfaced = false

func movement_underwater(delta, input_vector):
	var normal_input = input_vector.normalized()
	water_momentum = water_momentum.move_toward(normal_input * WATER_SPEED, WATER_ACCELERATION * delta)
	velocity = water_momentum
	if not is_on_floor():
		velocity += WATER_GRAVITY * delta
	if velocity.x > WATER_SPEED:
		velocity.x = WATER_SPEED
	if velocity.y > WATER_SPEED:
		velocity.y = WATER_SPEED
	
	oxygen += delta
	if oxygen >= max_oxygen:
		get_tree().reload_current_scene()
	
	light_size = move_toward(light_size, LIGHT_SIZE_UNDERWATER, (LIGHT_SWITCH_SPEED * abs(light_size - LIGHT_SIZE_UNDERWATER)) * delta)
	
	just_surfaced = false

func set_underwater_mode(value):
	if value == underwater_mode:
		return
	underwater_mode = value
	if !value:
		just_surfaced = true
