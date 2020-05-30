extends KinematicBody2D

var num;

func _ready():
	num = rand_range(0, 1);
	print(":)")
	
func attack():
	print(num);
	scale.x = 10 * num
