// MARK: - Domain/Entities/Usuario.swift
import Foundation

struct Usuario {
    let id: String
    let correo: String
    let nombre: String
    let racha: Racha
}

struct Racha {
    let actual: Int
    let mejor: Int
    let ultimaActividad: Date
}
