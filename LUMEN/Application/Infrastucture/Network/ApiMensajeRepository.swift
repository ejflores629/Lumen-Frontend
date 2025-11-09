// MARK: - Infrastructure/Network/ApiMensajeRepository.swift
import Foundation

class ApiMensajeRepository: ApiService, MensajeRepository {
    
    func obtenerTodosLosMensajes() async throws -> [Mensaje] {
        guard let url = URL(string: "\(baseURL)/mensajes") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiMensajes = try JSONDecoder().decode([APIMensaje].self, from: data)
        
        // Mapeo de DTO -> Dominio
        return apiMensajes.map {
            Mensaje(
                id: $0._id,
                mensaje: $0.mensaje,
                autor: $0.autor,
                categoria: CategoriaMensaje(rawValue: $0.categoria) ?? .desconocido
            )
        }
    }
}
