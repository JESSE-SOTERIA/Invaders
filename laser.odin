package main
import "core:fmt"
import rl "vendor:raylib"

Laser :: struct {
	position: rl.Vector2,
	velocity: Speed,
	active:   bool,
	hitbox:   rl.Rectangle,
}


//pass negative values of speed for opposite travelling lasers
new_laser :: proc(position: rl.Vector2, speed: f32) -> Laser {
	laser: Laser
	laser.position = position
	laser.velocity.y = speed
	laser.active = true
	laser.hitbox = rl.Rectangle{laser.position.x, laser.position.y, 4, 15}

	return laser
}

draw_laser :: proc(laser: ^Laser) {
	if laser.active {
		rl.DrawRectangle(i32(laser.position.x), i32(laser.position.y), 4, 15, rl.YELLOW)
		rl.DrawRectangle(i32(laser.hitbox.x), i32(laser.hitbox.y), 4, 15, {255, 255, 255, 0})
	}
}

update_laser :: proc(laser: ^Laser, game: ^Game) {
	laser.position.y += laser.velocity.y
	laser.hitbox.y += laser.velocity.y

	for &barrier in game.barriers {
		if rl.CheckCollisionRecs(laser.hitbox, barrier.hitbox) {
			//destroy the laser
			laser.active = false
			//reduce health of the barrier.
			barrier.health -= 2
		}
	}

	if laser.active {
		if i32(laser.position.y) > game.screen_height || laser.position.y < 0 {
			laser.active = false
		}
	}
}
