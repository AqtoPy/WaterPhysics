extends Area3D

func _ready() -> void:
    connect("body_entered", Callable(get_parent(), "_on_body_entered"))
    connect("body_exited", Callable(get_parent(), "_on_body_exited"))
