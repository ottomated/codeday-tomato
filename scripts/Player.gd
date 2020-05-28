extends KinematicBody2D

export (int) var GRAVITY = 1800;
export (int) var MAX_SPEED = 200;
export (int) var JUMP_SPEED = -400;
export (int) var ACCEL = 100;
export (int) var DEACCEL = 200;
const MAX_SLOPE_ANGLE = 40;

var vel = Vector2();

func _physics_process(delta):
	
	var hvel = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor() and Input.is_action_pressed("move_jump"):
		vel.y = JUMP_SPEED;
	
	vel.y += delta * GRAVITY;
	
	var target = hvel * MAX_SPEED;
	
	var accel = ACCEL if sign(vel.x) == sign(target) else DEACCEL;
	
	hvel = hvel + (target - hvel) * (accel * delta);
	vel.x = hvel;
	
	vel = move_and_slide(vel, Vector2.UP, false, 4, deg2rad(MAX_SLOPE_ANGLE));
