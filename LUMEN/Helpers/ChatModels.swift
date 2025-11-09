/// MARK: - Helpers/ChatModels.swift (Stubs para ChatSubViews)
import Foundation

// Stubs para que ChatSubViews compile
enum Sender {
    case user, ai
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let sender: Sender
    let timestamp: Date
}
