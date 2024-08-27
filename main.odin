package main

//NOTE: we can easily implement a power up system that boosts speed 
//or a nerf system that reduces speed based on the speed values of the player.

import rl "vendor:raylib"

main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(900, 600, "spaceInvaders")
	rl.SetTargetFPS(250)

	game := new_game()
	for !rl.WindowShouldClose() {
		//NOTE: handle player input
		handle_input_game(&game)

		rl.BeginDrawing()
		rl.ClearBackground({0, 0, 0, 1})
		draw_game(&game)
		rl.EndDrawing()
	}
	free_everything_game(&game)
	rl.CloseWindow()
}
