// MARK: - Infrastructure/Network/ApiService.swift
import Foundation

class ApiService {
    
    // Tu URL base (asegúrate de cambiarla para producción)
    let baseURL = "http://localhost:5000/api"
    
    // Decoders y Encoders (como los teníamos)
    var snakeCaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    var snakeCaseEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    // --- NUEVA FUNCIÓN ---
    // Helper para crear una solicitud PROTEGIDA
    func crearSolicitudProtegida(
        url: URL,
        metodo: String = "GET",
        token: String
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = metodo
        // Aquí adjuntamos el token
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
