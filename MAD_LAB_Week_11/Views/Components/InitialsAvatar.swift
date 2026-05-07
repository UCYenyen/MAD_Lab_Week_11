import SwiftUI

struct InitialsAvatar: View {
    let initials: String
    var size: CGFloat = 40

    var body: some View {
        Circle()
            .fill(Color.blue.opacity(0.18))
            .frame(width: size, height: size)
            .overlay(
                Text(initials)
                    .font(.system(size: size * 0.38, weight: .semibold))
                    .foregroundStyle(Color.blue)
            )
    }
}
