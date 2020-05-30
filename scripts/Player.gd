extends KinematicBody2D

export (int) var GRAVITY = 1000;
export (int) var LOW_JUMP_MULT = 2;
export (int) var FALL_MULT = 2.5;
export (int) var MAX_SPEED = 200;
export (int) var JUMP_SPEED = -400;
export (int) var ACCEL = 100;
export (int) var DEACCEL = 200;
const MAX_SLOPE_ANGLE = 40;

var vel = Vector2();

func _do_movement(delta):
	var hvel = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if is_on_floor() and Input.is_action_pressed("move_jump"):
		vel.y = JUMP_SPEED;
	
	var gravity_mult = 1;
	if vel.y > 0:
		gravity_mult = FALL_MULT;
	elif vel.y < 0 and not Input.is_action_pressed("move_jump"):
		gravity_mult = LOW_JUMP_MULT;
		
	vel.y += delta * GRAVITY * gravity_mult;
	
	var target = hvel * MAX_SPEED;
	
	var accel = ACCEL if sign(vel.x) == sign(target) else DEACCEL;
	
	hvel = hvel + (target - hvel) * (accel * delta);
	vel.x = hvel;
	
	vel = move_and_slide(vel, Vector2.UP, false, 4, deg2rad(MAX_SLOPE_ANGLE));

func _do_attacks(delta):
	if Input.is_action_just_pressed("attack_primary"):
		print("ATTACK");
	if Input.is_action_just_pressed("attack_secondary"):
		print("SECONDARY ATTACK");

func _physics_process(delta):
	_do_movement(delta);
	_do_attacks(delta);
