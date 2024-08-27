package main

import rl "vendor:raylib"

main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(900, 600, "spaceInvaders")
	rl.SetTargetFPS(250)

	player := new_spaceship()
	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground({150, 190, 220, 255})
		Spaceship_draw(&player)
		rl.EndDrawing()
	}

	delete_spaceship(&player)
	rl.CloseWindow()
}
