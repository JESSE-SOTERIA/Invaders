package main
import rl "vendor:raylib"
import "core:time"
import "core:strings"

//keep track of the elements in the game.

//TODO: @syntax: purge all the 'boomer' loops
// implement modern Odin syntax.

Game :: struct {
	player:         Spaceship,
	alien_names:    [3]string,
	alien_textures: [dynamic]rl.Texture2D,
	aliens:         [dynamic]Spaceship,
	barriers:       [dynamic]Barrier,
	velocity:       Speed "defined in movement code",
	stop_watch:     time.Stopwatch "to calculate fire rate and other factors",
	screen_width:   i32,
	screen_height:  i32,
}


new_game :: proc() -> Game {

	game: Game
	game.player = new_spaceship()
	game.alien_names = [3]string{"red", "green", "player"}
	game.aliens = make([dynamic]Spaceship, 0, 15)
	game.barriers = make([dynamic]Barrier, 0, 15)
	game.alien_textures = make([dynamic]rl.Texture2D, 0, 3)
	game.velocity.x = 7
	game.velocity.y = 7
	game.screen_width = rl.GetScreenWidth()
	game.screen_height = rl.GetScreenHeight()
	//TODO: @performance: make sure aliens and player use the game stopwatch for fire rate calculations
	// this should be done to reduce the number of entities keeping track of time at once.
	time.stopwatch_start(&game.stop_watch)

    //TODO: @aesthetic: implement a different system for generating the map of the level.
    // wave collapse and ______ are the main options.
	//make barriers
	gap := int((game.screen_width - (60 * 4)) / 4)
	for i in 1..<5 {
		append(&game.barriers, new_barrier({f32(i * gap), f32(game.screen_height - 100)}))
	}

	//make aliens
	//TODO: @complete: make the new aliens properly. make sure to pass in the values for the textures etc.
	for i := 0; i < len(game.aliens); i += 1 {
		if i < 5 {
			append(&game.aliens, new_alien(&game, {}, 0))
		} else if i < 10 {
			append(&game.aliens, new_alien(&game, {}, 1))
		} else if i < 15 {
			append(&game.aliens, new_alien(&game, {}, 2) )
		}
	}

  builder := strings.builder_make();

    for j := 0; j < len(game.alien_names); j += 1 {
        //clear the string for each new path
        strings.builder_reset(&builder);

        strings.write_string(&builder, "graphics/invaders2/");
        strings.write_string(&builder, game.alien_names[j]);
        texture_path := strings.to_string(builder);
        game.alien_textures[j] = rl.LoadTexture(strings.clone_to_cstring(texture_path));
    }

	return game
}


draw_game :: proc(game: ^Game) {
	draw_spaceship(&game.player)

	//loop by reference
	for &laser in game.player.lasers {
		draw_laser(&laser)
	}
	for &barrier, index in game.barriers {
		if barrier.health <= 0 {
			unordered_remove(&game.barriers, index)
		} else if barrier.health < 16 {
			//TODO: make this a variable
			barrier.height -= i32(7)
			draw_barrier(&barrier)
		} else {
			draw_barrier(&barrier)
		}
	}

	for &alien in game.aliens {
		draw_alien(&alien)

		for &laser in alien.lasers {
			draw_laser(&laser)
		}
	}
}


//NOTE: players are updated by keyboard movement
//file: movement.odin
update_game :: proc(game: ^Game) {
	update_all_lasers(game)
	update_alien_lasers(game)
	update_aliens(&game.aliens)
}


handle_input_game :: proc(game: ^Game) {

	switch {

	   case rl.IsKeyDown(rl.KeyboardKey.A):
	   	   move_left_player(game)

	   case rl.IsKeyDown(rl.KeyboardKey.D):
		  move_right_player(game)

	   case rl.IsKeyDown(rl.KeyboardKey.SPACE):
		  //just creates a new laser, the position of which is updated by the
		  //update game function.
		  firelaser_spaceship(&game.player)
	 }

}


//NOTE: call functions that free assets here
free_everything_game :: proc(game: ^Game) {
	delete_spaceship(&game.player)
}
