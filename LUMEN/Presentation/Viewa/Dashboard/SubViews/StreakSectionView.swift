import SwiftUI

// MARK: - Streak Section (Corregido)
struct StreakSectionView: View {
    // CORREGIDO: Usa el modelo de Dominio "Racha"
    let streak: Racha?
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Racha de bienestar")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppColors.Light.text)

            if isLoading {
                HStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Cargando racha...")
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.Light.textSecondary)
                }
            } else if let streak {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Actual")
                            .font(.system(size: 13))
                            .foregroundColor(AppColors.Light.textSecondary)
                        Text("\(streak.actual) días") // Corregido
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.Light.text)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Más larga")
                            .font(.system(size: 13))
                            .foregroundColor(AppColors.Light.textSecondary)
                        Text("\(streak.mejor) días") // Corregido
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(AppColors.Light.text)
                    }
                }
            } else {
                Text("No hay datos de racha disponibles.")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.Light.textSecondary)
            }
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
