// MARK: - Presentation/Views/Chat/ChatSubViews.swift
import SwiftUI
import UIKit

// Tu archivo de Chat, sin cambios.
// (Incluyo helpers al final para que compile)

struct ChatHeaderView: View {
    // ... (Tu código)
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.2.fill")
                .resizable().scaledToFit().frame(width: 28, height: 28)
                .foregroundColor(AppColors.Light.primary)
                .padding(10)
                .background(AppColors.Light.primaryLight)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("Asistente Lumen")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(AppColors.Light.text)
                Text("Tu compañero de bienestar")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.Light.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 20)
        .background(AppColors.Light.background)
        .overlay(
            Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder), alignment: .bottom
        )
    }
}
