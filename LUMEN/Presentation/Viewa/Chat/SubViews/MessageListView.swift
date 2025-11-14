import SwiftUI

struct MessagesListView: View {
    let messages: [Message]
    var body: some View {
        List(messages) { message in
            MessageBubble(message: message)
                .padding(.vertical, 8)
                 .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(AppColors.Light.backgroundSecondary)
                .id(message.id)
        }
        .listStyle(.plain)
        .padding(.horizontal, 8)
        .background(AppColors.Light.backgroundSecondary)
    }
}
