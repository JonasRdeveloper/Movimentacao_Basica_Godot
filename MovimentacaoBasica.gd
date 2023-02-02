extends KinematicBody

var vetor_movimento: Vector3
const velocidade_movimento: int = 10
var velocidade_y: float = 0.0
const Sensibilidade_do_mouse: float = 0.2
onready var CameraRaiz: Spatial = get_node("CameraRaiz")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(- deg2rad(event.relative.x) * Sensibilidade_do_mouse)
		CameraRaiz.rotate_x(- deg2rad(event.relative.y) * Sensibilidade_do_mouse)
		CameraRaiz.rotation.x = clamp(CameraRaiz.rotation.x, deg2rad(-70), deg2rad(70))

func _physics_process(_delta):
	Movimentacao_do_protagonista()
	Promover_movimento()


func Movimentacao_do_protagonista() -> void:
	var Nao_Mover = not Input.is_action_pressed("ui_up") and  not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("ui_left"):
		vetor_movimento -= transform.basis.x
	elif Input.is_action_pressed("ui_right"):
		vetor_movimento += transform.basis.x
		
	if Input.is_action_pressed("ui_down"):
		vetor_movimento += transform.basis.z
	elif Input.is_action_pressed("ui_up"):
		vetor_movimento -= transform.basis.z
		
	if Nao_Mover:
		vetor_movimento = Vector3.ZERO
		
func Promover_movimento() -> void:
	vetor_movimento = vetor_movimento.normalized() * velocidade_movimento
	var _Promover_movimento: Vector3 = move_and_slide(vetor_movimento + Vector3(0, velocidade_y, 0), Vector3.UP)
	
