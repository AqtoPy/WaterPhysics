extends MeshInstance3D

# Параметры воды
@export var density: float = 1.0  # Плотность воды
@export var wave_strength: float = 0.1
@export var wave_speed: float = 0.5

# Массив для хранения объектов в воде
var objects_in_water: Array = []

# Сила сопротивления воды
@export var water_drag: float = 0.1

func _ready() -> void:
    # Настройка шейдера
    material_override.set_shader_param("wave_height", wave_strength)
    material_override.set_shader_param("wave_speed", wave_speed)

func _process(delta: float) -> void:
    # Применяем силу плавучести к объектам
    for body in objects_in_water:
        if body is RigidBody3D:
            apply_buoyancy(body)
            apply_water_drag(body)

# Применение силы плавучести (Архимедова сила)
func apply_buoyancy(body: RigidBody3D) -> void:
    var volume = body.mass / density  # Объем вытесненной воды
    var buoyancy_force = Vector3.UP * volume * 9.8  # Сила Архимеда
    body.apply_central_force(buoyancy_force)

# Применение сопротивления воды
func apply_water_drag(body: RigidBody3D) -> void:
    body.linear_velocity *= (1.0 - water_drag)
    body.angular_velocity *= (1.0 - water_drag)

# Добавление объекта в воду
func _on_body_entered(body: Node) -> void:
    if body is RigidBody3D:
        objects_in_water.append(body)
        if body.has_method("enter_water"):
            body.enter_water()

# Удаление объекта из воды
func _on_body_exited(body: Node) -> void:
    if body is RigidBody3D:
        objects_in_water.erase(body)
        if body.has_method("exit_water"):
            body.exit_water()
