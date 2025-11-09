import Foundation

//// Coincide con Emocion.js (¡Ojo con snake_case!)
struct APIEmocionRequest: Codable {
    let user_correo: String
    let sentimiento: String
    let descripcion: String
}
