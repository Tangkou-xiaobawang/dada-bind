extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	#jishi()
	
	
var timer

'func _ready():
	jishi()
	pass'
	
# 创建一个定时器并连接到timeout信号
func jishi():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0  # 设置等待时间为1秒
	timer.one_shot = true  # 设置定时器仅执行一次
	timer.start()  # 启动定时器
	await timer.timeout
	queue_free()

