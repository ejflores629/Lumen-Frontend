// MARK: - Infrastructure/Network/ApiConsejoRepository.swift
import Foundation

class ApiConsejoRepository: ApiService, ConsejoRepository {
    
    func obtenerTodosLosConsejos() async throws -> [Consejo] {
        guard let url = URL(string: "\(baseURL)/consejos") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let apiConsejos = try JSONDecoder().decode([APIConsejo].self, from: data)
        
        // Mapeo de DTO -> Dominio
        return apiConsejos.map {
            Consejo(
                id: $0._id,
                texto: $0.texto,
                categoria: CategoriaConsejo(rawValue: $0.categoria) ?? .desconocido
            )
        }
    }
}
