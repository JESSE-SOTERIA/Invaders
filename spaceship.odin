package main

import "core:fmt"
import "core:runtime"
import "core:time"
import rl "vendor:raylib"

Spaceship :: struct {
	image:           rl.Texture2D,
	health: i32,
	position:        rl.Vector2,
	lasers:          [dynamic]Laser,
	stopwatch:       time.Stopwatch,
	fire_constraint: time.Duration,
}

new_spaceship :: proc() -> Spaceship {
	ship: Spaceship
	lasers := make([dynamic]Laser, 1, 11)

	ship.health = 30
	ship.image = rl.LoadTexture("graphics/invaders2/player.png")
	ship.position.x = f32((rl.GetScreenWidth() - ship.image.width) / 2)
	ship.position.y = f32(rl.GetScreenHeight() - ship.image.height)
	ship.lasers = lasers
	ship.fire_constraint = (150 * time.Millisecond)
	time.stopwatch_start(&ship.stopwatch)

	return ship
}

//TODO:make sure to call this function when the window is closed.
delete_spaceship :: proc(ship: ^Spaceship) {
	rl.UnloadTexture(ship.image)
}

draw_spaceship :: proc(ship: ^Spaceship) {
	rl.DrawTextureV(ship.image, ship.position, rl.WHITE)
}

firelaser_spaceship :: proc(ship: ^Spaceship) {
	if time.stopwatch_duration(ship.stopwatch) < ship.fire_constraint {
		return
	} else {
		laser := new_laser(
			{(ship.position.x + f32(ship.image.width / 2) - 2), ship.position.y}, //hard values dependent on the size of the Laser which also has hard values.
			-6,
		)
		append(&ship.lasers, laser)
		time.stopwatch_reset(&ship.stopwatch)
		time.stopwatch_start(&ship.stopwatch)
	}
}

//updates all laser positions and deletes ones that are not in the viewport
update_all_lasers :: proc(game: ^Game) {
	for &laser, index in game.player.lasers {
		if laser.active {
			update_laser(&laser, game)
		} else {
			unordered_remove(&game.player.lasers, index)
		}
	}
}
