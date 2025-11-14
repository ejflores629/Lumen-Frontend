// MARK: - Presentation/Views/Registration/SubViews/Step2View.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct Step2View: View {
    @Binding var note: String
    let noteUpdater: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cuéntame más")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.Light.text)
            
            Text("¿Qué pasó hoy? (Opcional)")
                .font(.system(size: 16))
                .foregroundColor(AppColors.Light.textSecondary)
                .padding(.bottom, 8)

            VStack(spacing: 8) {
                TextEditor(text: $note)
                    .frame(minHeight: 200, maxHeight: 300)
                    .padding(16)
                    .background(AppColors.Light.backgroundSecondary)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppColors.Light.cardBorder, lineWidth: 1)
                    )
                    .scrollContentBackground(.hidden)
                    .foregroundColor(AppColors.Light.text)
                    .onChange(of: note) { _, newValue in
                        noteUpdater(newValue)
                    }
                
                Text("\(note.count) caracteres")
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.Light.textTertiary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
