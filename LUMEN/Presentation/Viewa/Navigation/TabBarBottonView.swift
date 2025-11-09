// MARK: - Presentation/Views/Navigation/TabBarButton.swift
import SwiftUI

struct TabBarButton: View {
    
    let iconName: String
    let iconFilled: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? iconFilled : iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(label)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(isSelected ? AppColors.Light.primary : AppColors.Light.textSecondary)
        }
        // Quitamos el ancho fijo para que el 'HStack' principal
        // pueda asignarle el ancho correcto (1/3 de la pantalla).
        .frame(height: 44)
    }
}
