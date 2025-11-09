import SwiftUI

// MARK: - Tip Section (Corregido)
struct TipSectionView: View {
    // CORREGIDO: Usa el modelo de Dominio "Consejo"
    let tip: Consejo?
    let isLoading: Bool

    // CORREGIDO: Usa el enum de Dominio
    private func emoji(for categoria: CategoriaConsejo?) -> String {
        switch categoria {
        case .habitos: return "💧"
        case .autoestima: return "🧘‍♀️"
        case .descanso: return "✍️"
        case .relaciones: return "🚶‍♂️"
        case .foco: return "🎯"
        default: return "✨"
        }
    }
    
    // CORREGIDO: Usa el enum de Dominio
    private func title(for categoria: CategoriaConsejo?) -> String {
        return categoria?.rawValue ?? "Consejo"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Consejo del día")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppColors.Light.text)
                .padding(.horizontal, 4)
            
            if isLoading {
                LoadingCard(minHeight: 180)
            } else if let tip = tip {
                VStack(alignment: .center, spacing: 8) {
                    Text(emoji(for: tip.categoria))
                        .font(.system(size: 48))
                        .padding(.bottom, 8)
                    
                    Text(title(for: tip.categoria))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.Light.text)
                        .multilineTextAlignment(.center)
                    
                    Text(tip.texto) // Corregido
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.Light.textSecondary)
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(AppColors.Light.card)
                .cornerRadius(16)
                .shadow(color: AppColors.Light.shadow, radius: 8, x: 0, y: 2)
            }
        }
    }
}
