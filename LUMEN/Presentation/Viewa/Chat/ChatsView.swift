// MARK: - Presentation/Views/Chat/ChatView.swift
import SwiftUI

struct ChatView: View {
    
    // 1. Acepta el ViewModel inyectado
    @StateObject var vm: ChatViewModel
    
    var body: some View {
        ZStack {
            AppColors.Light.backgroundSecondary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ChatHeaderView()
                
                ScrollViewReader { proxy in
                    MessagesListView(messages: vm.messages)
                        .onChange(of: vm.messages.count) { _, _ in
                            if let lastMessage = vm.messages.last {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                }
                
                ChatInputView(
                    input: $vm.input,
                    isLoading: vm.isLoading,
                    handleSend: vm.handleSend // El vm inyectado maneja esto
                )
            }
        }
    }
}
