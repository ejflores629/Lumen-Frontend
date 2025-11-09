import Foundation

// Coincide con Usuario.js (¡Ojo con snake_case!)
struct APIUsuario: Codable {
    let _id: String
    let correo: String
    let nombre: String
    let racha: APIRacha
    let fecha_creacion: String // Usamos String para simpleza
}
