import SwiftUI

// Tu archivo original, sin cambios.
struct EmotionButton: View {
    let emotion: EmotionData
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(emotion.emoji)
                    .font(.system(size: 32))
                    .padding(.trailing, 16)
                
                Text(emotion.label)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(isSelected ? AppColors.Light.text : AppColors.Light.textSecondary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(isSelected ? AppColors.Light.primaryLight : AppColors.Light.backgroundSecondary)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? AppColors.Light.primary : .clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
