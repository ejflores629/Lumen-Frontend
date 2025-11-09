// MARK: - Application/UseCases/FetchHistorialEmocionesUseCase.swift
import Foundation

class FetchHistorialEmocionesUseCase {
    
    private let repository: EmocionRepository
    
    init(repository: EmocionRepository) {
        self.repository = repository
    }
    
    func execute(token: String) async throws -> [APIEmocion] {
        // Llama al repositorio y ordena las emociones por fecha (más nuevas primero)
        let emociones = try await repository.obtenerHistorialEmociones(token: token)
        // Nota: fecha es String; si es ISO-8601 normalizado, la comparación de String funciona.
        return emociones.sorted(by: { $0.fecha > $1.fecha })
    }
}
