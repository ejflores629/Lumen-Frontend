// MARK: - Application/UseCases/FetchConsejoUseCase.swift
import Foundation

class FetchConsejoUseCase {
    private let repository: ConsejoRepository
    
    init(repository: ConsejoRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Consejo] {
        return try await repository.obtenerTodosLosConsejos()
    }
}
