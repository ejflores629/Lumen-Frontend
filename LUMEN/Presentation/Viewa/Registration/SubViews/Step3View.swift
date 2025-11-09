// MARK: - Presentation/Views/Registration/SubViews/Step3View.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct Step3View: View {
    let isPending: Bool
    let aiResponse: String?
    let finishAction: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            if isPending {
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: AppColors.Light.primary))
                        .scaleEffect(1.5)
                    
                    Text("Generando tu mensaje motivacional...")
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.Light.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 80)
            } else if let response = aiResponse {
                VStack(alignment: .center, spacing: 20) {
                    Image(systemName: "sparkles")
                        .resizable().scaledToFit().frame(width: 32, height: 32)
                        .foregroundColor(AppColors.Light.accent)
                        .frame(width: 80, height: 80)
                        .background(AppColors.Light.accent.opacity(0.15))
                        .clipShape(Circle())
                        .padding(.bottom, 4)
                    
                    Text("Mensaje para ti")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(AppColors.Light.text)
                    
                    Text(response)
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.Light.text)
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .padding(24)
                        .background(AppColors.Light.backgroundSecondary)
                        .cornerRadius(16)
                        .padding(.bottom, 8)
                    
                    Button(action: finishAction) {
                        Text("Finalizar")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(AppColors.Light.background)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(AppColors.Light.primary)
                            .cornerRadius(12)
                    }
                }
            } else {
                Text("Ha ocurrido un error al generar la respuesta.")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
