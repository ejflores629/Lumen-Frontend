// MARK: - Application/Services/AuthService.swift
import Foundation
internal import Combine 

@MainActor
class AuthService: ObservableObject {
    
    @Published private(set) var token: String?
    @Published private(set) var usuario: Usuario? // Modelo de Dominio
    
    private let usuarioRepository: ApiUsuarioRepository
    
    // Helper para convertir las fechas de String a Date
    private static var isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    init(usuarioRepository: ApiUsuarioRepository) {
        self.usuarioRepository = usuarioRepository
    }
    
    func login(correo: String) async throws {
        let loginResponse = try await usuarioRepository.login(correo: correo)
        
        // --- INICIO DE LA CORRECCIÓN ---
        // Mapeamos el DTO (APIUsuarioAuth) al Modelo de Dominio (Usuario)
        let apiUser = loginResponse.usuario
        let apiRacha = apiUser.racha
        
        let ultimaActividadDate = Self.isoDateFormatter.date(from: apiRacha.ultimaActividad) ?? Date()
        
        self.usuario = Usuario(
            id: apiUser._id,
            correo: apiUser.correo,
            nombre: apiUser.nombre,
            racha: Racha( // Mapeamos la racha también
                actual: apiRacha.actual,
                mejor: apiRacha.mejor,
                ultimaActividad: ultimaActividadDate
            )
        )
        
        self.token = loginResponse.token
        // --- FIN DE LA CORRECCIÓN ---
    }
    
    func registrar(correo: String, nombre: String) async throws {
        _ = try await usuarioRepository.registrar(correo: correo, nombre: nombre)
        try await self.login(correo: correo)
    }
    
    func logout() {
        self.token = nil
        self.usuario = nil
        
        UserDefaults.standard.removeObject(forKey: ChatStorage.messagesKey)    }
}
