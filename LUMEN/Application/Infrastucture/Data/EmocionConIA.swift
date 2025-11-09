import Foundation

// DTO de Respuesta de Emociones (coincide con tu JSON)
struct EmocionConIA: Codable {
    let emocion: APIEmocion // Objeto de emocion anidado
    let mensajeIA: String
}
