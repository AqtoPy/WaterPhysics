extends RigidBody3D

# Параметры объекта
@export var density: float = 0.5  # Плотность объекта (если меньше плотности воды, будет плавать)
@export var water_drag: float = 0.1  # Сопротивление воды

var in_water: bool = false

func _ready() -> void:
    # Настройка массы объекта
    mass = density * 10.0  # Масса зависит от плотности

func _process(delta: float) -> void:
    if in_water:
        # Применяем сопротивление воды
        linear_velocity *= (1.0 - water_drag)
        angular_velocity *= (1.0 - water_drag)

# Обработка входа в воду
func enter_water() -> void:
    in_water = true

# Обработка выхода из воды
func exit_water() -> void:
    in_water = false
