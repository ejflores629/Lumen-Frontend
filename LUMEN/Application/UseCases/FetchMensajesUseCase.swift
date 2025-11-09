// MARK: - Application/UseCases/FetchMensajesUseCase.swift
import Foundation

class FetchMensajesUseCase {
    private let repository: MensajeRepository
    
    init(repository: MensajeRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Mensaje] {
        return try await repository.obtenerTodosLosMensajes()
    }
}
