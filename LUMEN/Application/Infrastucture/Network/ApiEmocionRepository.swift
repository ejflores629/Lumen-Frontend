// MARK: - Infrastructure/Network/ApiEmocionRepository.swift
import Foundation

// 2. Implementación (Actualizada)
class ApiEmocionRepository: ApiService, EmocionRepository {
    
    // Helper para convertir fechas
    private var isoDateDecoder: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    func crearEmocion(input: EmocionInput, token: String) async throws -> EmocionConIA {
        guard let url = URL(string: "\(baseURL)/emociones") else {
            throw URLError(.badURL)
        }
        
        // Usamos nuestro nuevo helper
        var request = crearSolicitudProtegida(url: url, metodo: "POST", token: token)
        
        // El body usa snake_case (según tu Emocion.js)
        request.httpBody = try snakeCaseEncoder.encode(input)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }

        // Decodificamos la nueva respuesta EmocionConIA
        // Tu doc dice que esta respuesta NO usa snake_case
        let emocionConIA = try snakeCaseDecoder.decode(EmocionConIA.self, from: data)
        return emocionConIA
    }
    
    
    func obtenerHistorialEmociones(token: String) async throws -> [APIEmocion] {
        
        // 1. Prepara la URL (GET /api/emociones)
        guard let url = URL(string: "\(baseURL)/emociones") else {
            throw URLError(.badURL)
        }
        
        // 2. Crea la solicitud PROTEGIDA (con el token)
        let request = crearSolicitudProtegida(url: url, metodo: "GET", token: token)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 3. Verifica el código de respuesta (espera un 200 OK)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // Si falla, lanzará el error -1011 (badServerResponse)
            throw URLError(.badServerResponse)
        }
        
        // 4. Decodifica el array de DTOs [APIEmocion]
        // Tu backend envía 'fecha' como String (ISODate)
        // El DTO APIEmocion usa snake_case para 'user_correo'
        let apiEmociones = try snakeCaseDecoder.decode([APIEmocion].self, from: data)
        
        // 5. Retorna directamente los DTOs (fecha es String en el DTO)
        return apiEmociones
    } // <-- Faltaba esta llave de cierre de la función
    // --- FIN DE LA CORRECCIÓN ---
    
} // <-- Esta es la llave de cierre de la clase
