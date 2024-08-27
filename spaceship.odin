package main

import rl "vendor:raylib"

Spaceship :: struct {
	image:    rl.Texture2D,
	position: rl.Vector2,
}

new_spaceship :: proc() -> Spaceship {
	ship: Spaceship

	ship.image = rl.LoadTexture("graphics/invaders2/player.png")
	ship.position.x = f32((rl.GetScreenWidth() - ship.image.width) / 2)
	ship.position.y = f32(rl.GetScreenHeight() - ship.image.height)

	return ship
}

//make sure you call this function when the window is closed.
delete_spaceship :: proc(ship: ^Spaceship) {
	rl.UnloadTexture(ship.image)
}

draw_spaceship :: proc(ship: ^Spaceship) {
	rl.DrawTextureV(ship.image, ship.position, rl.WHITE)
}

firelaser_spaceship :: proc() {

}
