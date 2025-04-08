import SwiftUI

struct AnimatedHeartButton: View {
    let isLiked: Bool
    let action: () -> Void
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isAnimating = true
                action()
            }
            // Reset animation state
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimating = false
            }
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(.title2)
                .foregroundColor(isLiked ? .red : .white)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.6))
                )
        }
    }
} 
