import SwiftUI

struct MessageBubble: View {
    let message: Message
    var isUser: Bool { message.sender == .user }
    
    // Cached time formatter for performance
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = .current
        f.doesRelativeDateFormatting = false
        f.dateStyle = .none
        f.timeStyle = .short
        return f
    }()
    
    // Helper to format the timestamp
    private func formattedTime(date: Date) -> String {
        Self.timeFormatter.string(from: date)
    }
    
    var body: some View {
                
        // 1. Se eliminó el GeometryReader
        
        HStack(alignment: .bottom, spacing: 12) {
            
            // 2. Lógica de posicionamiento (Spacer primero si es usuario)
            if isUser { Spacer() }
            
            if !isUser {
                AvatarIcon(sender: message.sender)
            }
            
            // 3. La burbuja (el VStack)
            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundColor(isUser ? AppColors.Light.background : AppColors.Light.text)
                    .lineSpacing(4)
                    .lineLimit(nil) // (Importante para textos largos)
                    .fixedSize(horizontal: false, vertical: true) // (Importante para textos largos)
                
                Text(formattedTime(date: message.timestamp))
                    .font(.system(size: 11))
                    .foregroundColor(isUser ? AppColors.Light.background.opacity(0.7) : AppColors.Light.textTertiary.opacity(0.8))
            }
            .padding(12)
            .background(isUser ? AppColors.Light.primary : AppColors.Light.card)
            .cornerRadius(16, corners: isUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
            // 4. Ancho máximo estable (sin GeometryReader)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isUser ? .trailing : .leading)
            .shadow(color: AppColors.Light.shadow, radius: 2, x: 0, y: 1)

            if isUser {
                AvatarIcon(sender: message.sender)
            }
            
            // 5. Spacer al final si es de la IA
            if !isUser { Spacer() }
        }
        
    }
}
