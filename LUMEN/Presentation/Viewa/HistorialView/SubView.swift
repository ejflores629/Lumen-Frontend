// --- Sub-vista para la fila ---

import SwiftUI
struct EmotionRowView: View {
    let emocion: APIEmocion
    
    // Formateador para mostrar la fecha al usuario
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    // Formateador para convertir el String ISO8601 de la API a Date
    private static let isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    // Fecha ya formateada para mostrar (con fallback al string original)
    private var formattedFecha: String {
        if let date = EmotionRowView.isoDateFormatter.date(from: emocion.fecha) {
            return dateFormatter.string(from: date)
        } else {
            // Si por alguna razón no se puede parsear, mostramos el string tal cual
            return emocion.fecha
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(emocion.sentimiento.capitalized)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppColors.Light.primary)
            
            Text(emocion.descripcion)
                .font(.system(size: 15))
                .foregroundColor(AppColors.Light.text)
                .lineLimit(3)
            
            Text(formattedFecha)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppColors.Light.textSecondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.Light.card)
        .cornerRadius(12)
        .shadow(color: AppColors.Light.shadow.opacity(0.1), radius: 4, y: 2)
    }
}
