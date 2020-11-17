
import SwiftUI

struct MatchingGameView: View {
    @ObservedObject var viewModel: MatchingGameViewModel
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.7)) {
                        viewModel.choose(card: card)
                    }
                    
                }
                .padding(3)
            }
            .padding()
            .foregroundColor(.blue)
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            })
        }
    }
}


struct CardView: View {
    var card: MatchingGame<Image>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                .onAppear {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        }
                    }
                    .padding(3).opacity(0.4)
                    .transition(.scale)
                    
                    
                    card.content
                        .resizable()
                        .scaledToFit()
                        .frame(width: min(geometry.size.width, geometry.size.height) * imageScaleFactor)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 0.8).repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)
                
            }
        }
    }
    
    // Drawing Constants
    
    private let imageScaleFactor: CGFloat = 0.7
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingGameView(viewModel: MatchingGameViewModel())
    }
}
