// MARK: - Infrastructure/Network/ApiUsuarioRepository.swift
import Foundation

protocol UsuarioRepository {
    func login(correo: String) async throws -> LoginResponse
    func registrar(correo: String, nombre: String) async throws
}
