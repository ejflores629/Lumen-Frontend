// MARK: - Presentation/Views/Common/LoadingCard.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct LoadingCard: View {
    let minHeight: CGFloat

    var body: some View {
        ZStack {
            AppColors.Light.card

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Rectangle()
                        .fill(AppColors.Light.textTertiary.opacity(0.4))
                        .frame(height: 14)
                        .cornerRadius(7)
                }
                Rectangle()
                    .fill(AppColors.Light.textTertiary.opacity(0.25))
                    .frame(height: 12)
                    .cornerRadius(6)
                Rectangle()
                    .fill(AppColors.Light.textTertiary.opacity(0.2))
                    .frame(height: 12)
                    .cornerRadius(6)
                    .opacity(0.9)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, alignment: .leading)
        .background(AppColors.Light.card)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColors.Light.cardBorder, lineWidth: 1)
        )
        .shadow(color: AppColors.Light.shadow, radius: 8, x: 0, y: 2)
    }
}
