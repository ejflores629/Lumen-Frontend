import Foundation

// --- DTOs para DECODIFICAR (GET) ---

// Coincide con Mensaje.js
struct APIMensaje: Codable {
    let _id: String
    let mensaje: String
    let autor: String
    let categoria: String
}
