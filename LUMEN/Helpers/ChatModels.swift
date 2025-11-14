// MARK: - Helpers/ChatModels.swift (Stubs para ChatSubViews)
import Foundation

// Stubs para que ChatSubViews compile
enum Sender: Codable { // <-- AÑADIR ESTO
    case user, ai
}

struct Message: Identifiable, Codable {
    let id: UUID
    let text: String
    let sender: Sender
    let timestamp: Date
    
}
