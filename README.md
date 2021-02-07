# chess
Command line chess game built with Ruby.  Built as a learning project for [The Odin Project](https://www.theodinproject.com/lessons/ruby-final-project).

## Instructions
- The basic rules of chess can be found [here](https://www.chessvariants.com/d.chess/chess.html).
- To play, clone the repository, cd into the directory and run `ruby lib/main.rb` or check out a live version at my [repl.it](https://repl.it/@QuentinPongratz/chess#README.md)
- The colors of the pieces do not necessarily match the colors used in prompts due to terminal settings. The 'white' pieces are those on the bottom of the board displayed with just outlines on the characters, and the 'black' pieces are those that start at the top of the board with their characters filled.
- In order to castle, input the correct destination for the king, and the rook will move where it needs to if you are able to castle.

## Learning Goals
- Put everything together I've learned so far with Ruby.
- Really stretch my limits with a big project.

### Reflection
- I really learned both the value for testing and how bad I am at testing on this project. With connect 4, it was easy to not really see why testing was so important, because the scale of the game is quite a bit smaller than chess. With something as big as chess, some of the things I need to test for, are quite a bit down the line if you take the game and try to create the conditions necessary to test. So it's great to be able to test that checkmate works without having to first setup a checkmate. I've also found how easy it is to think you're testing every aspect of something and just be overlooking all you really need to be testing. I got pawns working with their diagonal attacks according to my tests, but then actually running the game it would crash becuase I didn't have tests that were actually covering the whole of the methods that were at play.
- I think I thought pretty well about the organization of this project before starting, but I still ran into one issue and that was, my board class got too big. I think if I would do this again, I would separate some of the logic of the board about moves to its own class called movement or something. That's an area I'll need to work on. After a lot of thinking, I was able to parse out that all pieces would have common code and the individual pieces should inherit most of this. But the differentiation between board and movement feels more abstract. I'm still not even sure this is the right distinction to make becuase conceptually they still feel like two very linked classes, but maybe in the act of separating them, I would see more how they are their own thing.
- It's weird how the most basic piece when thinking about the game of chess, is actually the hardest one to describe the behavior of to a computer. (At least as a not so great chess player, maybe good players already think about this)
- Having thought about chess so much and dissected it for this project, it has given me a new appreciation for the game even if I still probably won't play it too much after this.
- It was really nice having already designed a save system for hangman, to not have to recode all of that from scratch for this project. All it took to implement was minimal changes to what to display for saving and loading as I used a different display method for this project.
