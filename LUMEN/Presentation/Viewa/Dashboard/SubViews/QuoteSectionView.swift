import SwiftUI


// MARK: - Quote Section (Corregido)
struct QuoteSectionView: View {
    // CORREGIDO: Usa el modelo de Dominio "Mensaje"
    let quote: Mensaje?
    let isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Inspiración del día")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppColors.Light.text)
                .padding(.horizontal, 4)
            
            if isLoading {
                LoadingCard(minHeight: 140)
            } else if let quote = quote {
                VStack(alignment: .leading, spacing: 16) {
                    Text("“\(quote.mensaje)”") // Corregido
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.Light.text)
                        .lineSpacing(6)
                        .italic()
                    
                    Text("— \(quote.autor)") // Corregido
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.Light.primary)
                }
                .padding(24)
                .background(AppColors.Light.card)
                .cornerRadius(16)
                .shadow(color: AppColors.Light.shadow, radius: 8, x: 0, y: 2)
            }
        }
    }
}
