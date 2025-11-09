import Foundation

struct APIUsuarioAuth: Codable {
    let _id: String
    let correo: String
    let nombre: String
    let racha: APIRacha
    let fechaCreacion: String
}
