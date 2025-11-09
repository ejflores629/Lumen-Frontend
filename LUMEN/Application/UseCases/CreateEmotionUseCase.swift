/// MARK: - Application/UseCases/CreateEmocionUseCase.swift
import Foundation

class CreateEmocionUseCase {
    private let repository: EmocionRepository
    
    init(repository: EmocionRepository) {
        self.repository = repository
    }
    
    func execute(sentimiento: String, descripcion: String, correo: String, token: String) async throws -> String {
        let input = EmocionInput(sentimiento: sentimiento, descripcion: descripcion)
        let result = try await repository.crearEmocion(input: input, token: token)
        return result.mensajeIA
    }
}
