import Foundation

// DTO para la Emocion anidada
struct APIEmocion: Codable, Identifiable {
    // Exponemos 'id' para SwiftUI usando el _id de la API
    var id: String { _id }
        
        let _id: String
        let userCorreo: String
        let sentimiento: String
        let descripcion: String
        let fecha: String
}
