// MARK: - Domain/Entities/Mensaje.swift
import Foundation

struct Mensaje {
    let id: String
    let mensaje: String
    let autor: String
    let categoria: CategoriaMensaje
}

enum CategoriaMensaje: String {
    case reflexion = "Reflexión"
    case inspiracion = "Inspiración"
    case superacion = "Superación"
    case anclaje = "Anclaje"
    case motivacion = "Motivación"
    case desconocido
}
