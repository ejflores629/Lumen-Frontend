// MARK: - Infrastructure/Network/ApiChatRepository.swift
import Foundation

// 1. Protocolo
protocol ChatRepository {
    func enviarPrompt(prompt: String, token: String) async throws -> ChatResponse
}

// 2. Implementación
class ApiChatRepository: ApiService, ChatRepository {
    
    func enviarPrompt(prompt: String, token: String) async throws -> ChatResponse {
        // Llama a /api/chat
        guard let url = URL(string: "\(baseURL)/chat") else {
            throw URLError(.badURL)
        }
        
        // 1. Crea la solicitud PROTEGIDA (con el token)
        var request = crearSolicitudProtegida(url: url, metodo: "POST", token: token)
        
        // 2. Adjunta el body { "prompt": "..." }
        request.httpBody = try JSONEncoder().encode(ChatInput(prompt: prompt))
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 3. Espera un 200 (OK). Si falla, lanza el error
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // 4. Decodifica la respuesta { "response": "..." }
        let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        return chatResponse
    }
}
