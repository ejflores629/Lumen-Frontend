import SwiftUI

struct MessagesListView: View {
    let messages: [Message]
    // ... (Tu código)
    var body: some View {
        List(messages) { message in
            MessageBubble(message: message)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                .listRowBackground(AppColors.Light.backgroundSecondary)
                .id(message.id)
        }
        .listStyle(.plain)
        .padding(.horizontal, 8)
        .background(AppColors.Light.backgroundSecondary)
    }
}
