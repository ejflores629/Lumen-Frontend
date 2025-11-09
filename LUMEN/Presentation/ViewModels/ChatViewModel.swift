// MARK: - Presentation/ViewModels/ChatViewModel.swift
import Foundation
internal import Combine

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var input: String = ""
    @Published var isLoading: Bool = false
    
    private let chatRepository: ChatRepository
    private let authService: AuthService
    
    init(chatRepository: ChatRepository, authService: AuthService) {
        self.chatRepository = chatRepository
        self.authService = authService
        
        messages.append(
            Message(
                text: "¡Hola! Soy Lumen, tu asistente de bienestar. ¿Cómo puedo ayudarte hoy?",
                sender: .ai,
                timestamp: Date()
            )
        )
    }

    func handleSend() {
        guard !input.trimmingCharacters(in: .whitespaces).isEmpty,
              let token = authService.token else {
            return
        }
        
        let userMessage = Message(text: input, sender: .user, timestamp: Date())
        self.messages.append(userMessage)
        
        let promptParaEnviar = input
        self.input = ""
        self.isLoading = true
        
        Task {
            do {
                let respuesta = try await chatRepository.enviarPrompt(
                    prompt: promptParaEnviar,
                    token: token
                )
                
                let aiResponse = Message(
                    text: respuesta.response,
                    sender: .ai,
                    timestamp: Date()
                )
                self.messages.append(aiResponse)
                
            } catch {
                // --- INICIO DE LA CORRECCIÓN DEL LOG ---
                
                // 1. Imprimir el error DETALLADO en la consola de Xcode
                print("\n--- ¡ERROR EN CHAT VIEW MODEL! ---")
                print("Error al llamar a chatRepository.enviarPrompt:")
                print(error) // Imprime el error completo (ej. URLError, DecodingError)
                print("--- FIN DEL ERROR ---")

                // 2. Mostrar un mensaje de error más útil en la app
                let errorMessage: String
                if let urlError = error as? URLError {
                    errorMessage = "Error de red: \(urlError.localizedDescription)"
                } else if error is DecodingError {
                    errorMessage = "Error al leer la respuesta del servidor (JSON no válido)."
                } else {
                    errorMessage = "Error inesperado: \(error.localizedDescription)"
                }
                
                let errorResponse = Message(
                    text: "Lo siento, falló la conexión. \(errorMessage)",
                    sender: .ai,
                    timestamp: Date()
                )
                self.messages.append(errorResponse)
                
                // --- FIN DE LA CORRECCIÓN DEL LOG ---
            }
            self.isLoading = false
        }
    }
}
