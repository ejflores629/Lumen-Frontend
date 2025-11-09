// MARK: - Presentation/Views/Registration/SubViews/FooterView.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct FooterView: View {
    let step: Int
    let canProceed: Bool
    let handleBack: () -> Void
    let handleNext: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder)
            
            HStack {
                if step > 1 {
                    Button(action: handleBack) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.left")
                                .resizable().scaledToFit().frame(width: 20, height: 20)
                                .foregroundColor(AppColors.Light.primary)
                            
                            Text("Atrás")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppColors.Light.primary)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Button(action: handleNext) {
                    HStack(spacing: 8) {
                        Text(step == 1 ? "Continuar" : "Registrar")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(canProceed ? AppColors.Light.background : AppColors.Light.textTertiary)
                        
                        Image(systemName: "arrow.right")
                            .resizable().scaledToFit().frame(width: 20, height: 20)
                            .foregroundColor(canProceed ? AppColors.Light.background : AppColors.Light.textTertiary)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 24)
                    .background(canProceed ? AppColors.Light.primary : AppColors.Light.cardBorder)
                    .cornerRadius(12)
                }
                .buttonStyle(.plain)
                .disabled(!canProceed)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .background(AppColors.Light.background)
    }
}
