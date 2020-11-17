
import SwiftUI

@main
struct MatchingGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = MatchingGameViewModel()
            MatchingGameView(viewModel: game)
        }
    }
}
