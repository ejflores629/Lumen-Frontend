/// MARK: - Domain/Entities/Consejo.swift
import Foundation

struct Consejo {
    let id: String
    let texto: String
    let categoria: CategoriaConsejo
}

enum CategoriaConsejo: String {
    case habitos = "Hábitos"
    case autoestima = "Autoestima"
    case descanso = "Descanso"
    case relaciones = "Relaciones"
    case foco = "Foco"
    case desconocido
}
