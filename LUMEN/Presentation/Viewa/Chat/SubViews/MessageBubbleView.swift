import SwiftUI


struct MessageBubble: View {
    let message: Message
    var isUser: Bool { message.sender == .user }
    // ... (Tu código)
    private func formattedTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let maxBubbleWidth = proxy.size.width * 0.75

            HStack(alignment: .bottom, spacing: 12) {
                if isUser { Spacer() }
                if !isUser {
                    AvatarIcon(sender: message.sender)
                }
                VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                    Text(message.text)
                        .font(.system(size: 15))
                        .foregroundColor(isUser ? AppColors.Light.background : AppColors.Light.text)
                        .lineSpacing(4)
                    Text(formattedTime(date: message.timestamp))
                        .font(.system(size: 11))
                        .foregroundColor(isUser ? AppColors.Light.background.opacity(0.7) : AppColors.Light.textTertiary.opacity(0.8))
                }
                .padding(12)
                .background(isUser ? AppColors.Light.primary : AppColors.Light.card)
                .cornerRadius(16, corners: isUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                .frame(maxWidth: maxBubbleWidth, alignment: isUser ? .trailing : .leading)
                .shadow(color: AppColors.Light.shadow, radius: 2, x: 0, y: 1)
                if isUser {
                    AvatarIcon(sender: message.sender)
                }
                if !isUser { Spacer() }
            }
            .frame(width: proxy.size.width, alignment: .leading)
        }
        .frame(minHeight: 0)
    }
}
