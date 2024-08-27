package main
import "core:fmt"
import rl "vendor:raylib"

Laser :: struct {
	position: rl.Vector2,
	velocity: Speed,
	active:   bool,
}


new_laser :: proc(position: rl.Vector2, speed: f32) -> Laser {
	laser: Laser
	laser.position = position
	laser.velocity.y = speed
	laser.active = true

	return laser
}

draw_laser :: proc(laser: ^Laser) {
	if laser.active {
		rl.DrawRectangle(i32(laser.position.x), i32(laser.position.y), 4, 15, rl.YELLOW)
	}
}

update_laser :: proc(laser: ^Laser, game: ^Game) {
	laser.position.y += laser.velocity.y
	if laser.active {
		if i32(laser.position.y) > game.screen_height || laser.position.y < 0 {
			laser.active = false
			fmt.println("laser inactive\n")
		}
	}
}
