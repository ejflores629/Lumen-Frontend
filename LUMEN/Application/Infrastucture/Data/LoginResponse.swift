import Foundation

// DTO de Respuesta de Login (coincide con tu JSON)
struct LoginResponse: Codable {
    let usuario: APIUsuarioAuth // Objeto de usuario anidado
    let token: String
}
