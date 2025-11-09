// MARK: - Application/Repositories/ConsejoRepository.swift
import Foundation

protocol ConsejoRepository {
    func obtenerTodosLosConsejos() async throws -> [Consejo]
}
