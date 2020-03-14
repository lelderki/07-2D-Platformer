extends KinematicBody2D

const MOVE_SPEED = 100
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

export var acceleration = 0.1
export var health = 100

var y_velo = 0 
var facing_right = false 

signal health_changed

func _ready():
	emit_signal("health_changed")

func change_health(h):
	health += h
	emit_signal("health_changed")
	if health <= 0:
		die()

func die():
	queue_free()
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func _physics_process(delta):
	var move_dir = 0 
	if Input.is_action_pressed("move_right"):
		move_dir += 1.5
		y_velo += acceleration
	if Input.is_action_pressed("move_left"):
		move_dir -= 1.5
		y_velo -= acceleration
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0,-1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	if facing_right and move_dir > 0:
		flip()
	if !facing_right and move_dir < 0:
		flip()
	#figure out why it wont flip back in videdo find code for this part #9:03???
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
		
func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)


#9:41


func _on_HitBox_body_entered(body):
	if body.get_parent().name == 'Enemies':
		change_health(-10)


func _on_HitHead_body_entered(body):
	if body.name == 'Walls':
		y_velo = 0
