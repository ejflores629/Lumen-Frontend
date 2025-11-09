import Foundation

// Este enum lo usará el ViewModel
enum EmotionType: String, CaseIterable {
    case feliz, bien, normal, mal, terrible
}

// Este struct lo usa la Vista (EmotionButton)
struct EmotionData: Identifiable {
    let id = UUID()
    let type: EmotionType
    let emoji: String
    let label: String
}

// Datos que usa tu Step1View
let emotionsData: [EmotionData] = [
    .init(type: .feliz, emoji: "😄", label: "Feliz"),
    .init(type: .bien, emoji: "🙂", label: "Bien"),
    .init(type: .normal, emoji: "😐", label: "Normal"),
    .init(type: .mal, emoji: "😕", label: "Mal"),
    .init(type: .terrible, emoji: "😞", label: "Terrible")
]
