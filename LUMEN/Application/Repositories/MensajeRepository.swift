// MARK: - Application/Repositories/MensajeRepository.swift
import Foundation

protocol MensajeRepository {
    func obtenerTodosLosMensajes() async throws -> [Mensaje]
}
