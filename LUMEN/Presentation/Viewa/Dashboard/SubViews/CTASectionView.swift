import SwiftUI

// MARK: - CTA Section
struct CTASectionView: View {
    let action: () -> Void
    // Tu archivo original, sin cambios.
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Registra tu estado")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppColors.Light.text)

            Text("Lleva un seguimiento de cómo te sientes hoy para mejorar tu bienestar con el tiempo.")
                .font(.system(size: 14))
                .foregroundColor(AppColors.Light.textSecondary)

            Button(action: action) {
                HStack {
                    Spacer()
                    Text("Registrar ahora")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.Light.background)
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(AppColors.Light.primary)
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.Light.card)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColors.Light.cardBorder, lineWidth: 1)
        )
        .shadow(color: AppColors.Light.shadow, radius: 2, x: 0, y: 1)
    }
}
