// MARK: - Presentation/Views/Registration/SubViews/Step1View.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct Step1View: View {
    @Binding var selectedEmotion: EmotionType?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("¿Cómo te sientes hoy?")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.Light.text)
            
            Text("Selecciona la emoción que mejor describe tu estado actual")
                .font(.system(size: 16))
                .foregroundColor(AppColors.Light.textSecondary)
                .padding(.bottom, 16)

            VStack(spacing: 12) {
                ForEach(emotionsData) { emotion in
                    EmotionButton(emotion: emotion, isSelected: emotion.type == selectedEmotion) {
                        selectedEmotion = emotion.type
                    }
                }
            }
        }
    }
}
