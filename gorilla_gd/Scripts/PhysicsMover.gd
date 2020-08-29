extends Node2D

export var dest=Vector2.ZERO
export var start=Vector2.ZERO
export var speed=10

var idle_time


var d=[]
var s=[]
var dir=1

onready var n=get_child_count()

func _ready():
	print(n)
	d.resize(n)
	s.resize(n)
	for i in range(1,n):
		d[i]=get_child(i).position+dest
		s[i]=get_child(i).position+start
	
	if 1:
		var mk1=preload("res://Mark.tscn").instance()
		add_child(mk1)
		mk1.position=dest
		var mk2=preload("res://Mark.tscn").instance()
		add_child(mk2)
		mk2.position=start

func _physics_process(delta):
	
	if Globals.map_freeze:
		return
	
	for i in range(1,n):
		var di=(d[i]-s[i]).normalized()*speed
		get_child(i).position+=di*delta
		
#		get_child(i).translate(di*delta)
#		get_child(i).move_and_slide(di,Vector2.UP)
#		get_child(i).move_and_collide(di*delta)
#		print(d)
	
	if (get_child(1).position-d[1]).x*dir>0:
		dir=-dir
		for i in range(1,n):
			var aux=d[i]
			d[i]=s[i]
			s[i]=aux
	










