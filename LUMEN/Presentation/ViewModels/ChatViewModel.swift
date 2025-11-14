// MARK: - Presentation/ViewModels/ChatViewModel.swift
import Foundation
internal import Combine

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = [] {
        didSet {
            saveMessages()
        }
    }
    @Published var input: String = ""
    @Published var isLoading: Bool = false
    
    private let chatRepository: ChatRepository
    private let authService: AuthService
    
    private let messagesKey = "chatMessages"
    
    init(chatRepository: ChatRepository, authService: AuthService) {
        self.chatRepository = chatRepository
        self.authService = authService
        
        loadMessages()
    }
    
    private func loadMessages() {
        guard let data = UserDefaults.standard.data(forKey: messagesKey),
              let savedMessages = try? JSONDecoder().decode([Message].self, from: data) else {
            
            // Si no hay nada guardado, añadimos el mensaje inicial
            messages.append(
                Message(
                    id: UUID(),
                    text: "¡Hola! Soy Lumen, tu asistente de bienestar. ¿Cómo puedo ayudarte hoy?",
                    sender: .ai,
                    timestamp: Date()
                )
            )
            return
        }
        
        // Si se cargaron mensajes, los asignamos
        self.messages = savedMessages
    }
    
    private func saveMessages() {
        if let data = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(data, forKey: messagesKey)
        }
    }
    
    func handleSend() {
        guard !input.trimmingCharacters(in: .whitespaces).isEmpty,
              let token = authService.token else {
            return
        }
        
        let userMessage = Message(id: UUID(), text: input, sender: .user, timestamp: Date())
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
                    id: UUID(),
                    text: respuesta.response,
                    sender: .ai,
                    timestamp: Date()
                )
                self.messages.append(aiResponse)
                
            } catch {
                
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
                    id: UUID(),
                    text: "Lo siento, falló la conexión. \(errorMessage)",
                    sender: .ai,
                    timestamp: Date()
                )
                self.messages.append(errorResponse)
                
            }
            self.isLoading = false
        }
    }
}
