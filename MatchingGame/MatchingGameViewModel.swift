
import SwiftUI

class MatchingGameViewModel: ObservableObject {
    @Published private var game: MatchingGame<Image> = MatchingGameViewModel.createMatchingGame()
    
    private static func createMatchingGame() -> MatchingGame<Image> {
        let animals: Array<Image> = [
            Image("elephant"), Image("giraffe"), Image("hippo"), Image("monkey"), Image("panda"),
            Image("parrot"), Image("penguin"), Image("pig"), Image("chick"), Image("chicken"),
            Image("zebra"), Image("walrus"), Image("owl"), Image("moose"), Image("narwhal"),
            Image("cow")
        ]
        return MatchingGame<Image>(numberOfPairsOfCards: animals.count) { pairIndex in
            return animals[pairIndex]
        }
    }
    
    var cards: Array<MatchingGame<Image>.Card> {
        game.cards
    }
    
    func choose(card: MatchingGame<Image>.Card) {
        game.choose(card: card)
    }
    
    func resetGame() {
        game = MatchingGameViewModel.createMatchingGame()
    }
}

