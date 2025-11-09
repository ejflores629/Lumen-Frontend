// MARK: - Application/Repositories/EmocionRepository.swift
import Foundation

protocol EmocionRepository {
    // Necesita el token y los datos de entrada
    func crearEmocion(input: EmocionInput, token: String) async throws -> EmocionConIA
    // GET /emociones (historial)
    func obtenerHistorialEmociones(token: String) async throws -> [APIEmocion]
}
