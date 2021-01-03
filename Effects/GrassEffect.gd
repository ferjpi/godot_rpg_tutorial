extends Node2D

onready var animatedSprite = $AnimatedSprite

func _ready():
#	connect("animation_finished", self, "_on_animation_finished")
	animatedSprite.play("Animate")


func _on_AnimatedSprite_animation_finished():
	queue_free()
