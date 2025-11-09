// MARK: - Presentation/Views/Registration/SubViews/HeaderView.swift
import SwiftUI

// Tu archivo original, sin cambios.
struct HeaderView: View {
    let step: Int
    let closeAction: () -> Void

    var body: some View {
        HStack {
            Button(action: closeAction) {
                Image(systemName: "xmark")
                    .resizable().scaledToFit().frame(width: 20, height: 20)
                    .foregroundColor(AppColors.Light.text)
            }
            .frame(width: 40, height: 40)
            
            Spacer()
            
            HStack(spacing: 8) {
                ForEach(1...3, id: \.self) { s in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(s <= step ? AppColors.Light.primary : AppColors.Light.cardBorder)
                }
            }
            
            Spacer()
            
            Color.clear.frame(width: 40, height: 40)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(AppColors.Light.background)
        .overlay(
            Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder), alignment: .bottom
        )
    }
}
