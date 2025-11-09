import SwiftUI


struct AvatarIcon: View {
    let sender: Sender
    // ... (Tu código)
    var body: some View {
        ZStack {
            Circle()
                .fill(sender == .user ? AppColors.Light.primary : AppColors.Light.accent)
                .frame(width: 36, height: 36)
            
            Image(systemName: sender == .user ? "person.fill" : "sparkles")
                .resizable().scaledToFit().frame(width: 18, height: 18)
                .foregroundColor(AppColors.Light.background)
        }
    }
}
