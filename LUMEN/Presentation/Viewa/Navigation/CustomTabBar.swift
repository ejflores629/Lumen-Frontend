// MARK: - Presentation/Views/Navigation/CustomTabBar.swift
import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: ContentView.Tab
    let onModalButtonTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // 1. El fondo de la barra
            HStack(spacing: 0) {
                
                // Botón "Hoy"
                                TabBarButton(
                                    iconName: "sun.max",
                                    iconFilled: "sun.max.fill",
                                    label: "Hoy",
                                    isSelected: selectedTab == .hoy,
                                    action: {
                                        selectedTab = .hoy
                                    }
                                )
                                .frame(maxWidth: .infinity) // Ocupa 1/5

                                
                                // Botón "Historial"
                                TabBarButton(
                                    iconName: "calendar", // (Icono sugerido)
                                    iconFilled: "calendar", // (Icono sugerido)
                                    label: "Historial",
                                    isSelected: selectedTab == .historial,
                                    action: {
                                        selectedTab = .historial
                                    }
                                )
                                .frame(maxWidth: .infinity) // Ocupa 1/5


                                // Espacio para el botón central
                                Spacer()
                                    .frame(maxWidth: .infinity) // Ocupa 1/5

                                // Botón "Asistente"
                                TabBarButton(
                                    iconName: "message",
                                    iconFilled: "message.fill",
                                    label: "Asistente",
                                    isSelected: selectedTab == .asistente,
                                    action: {
                                        selectedTab = .asistente
                                    }
                                )
                                .frame(maxWidth: .infinity) // Ocupa 1/5


                                // Botón "Perfil" (Ya que también faltaba)
                                TabBarButton(
                                    iconName: "person", // (Icono sugerido)
                                    iconFilled: "person.fill", // (Icono sugerido)
                                    label: "Perfil",
                                    isSelected: selectedTab == .perfil,
                                    action: {
                                        selectedTab = .perfil
                                    }
                                )
                                .frame(maxWidth: .infinity) //
            }
            .padding(.horizontal, 24)
            .frame(height: 50)
            .frame(maxWidth: .infinity) // <-- Se asegura que el fondo ocupe todo el ancho
            .background(
                AppColors.Light.background
                    // Redondeamos solo las esquinas de arriba
                    .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
                    .shadow(color: AppColors.Light.shadow.opacity(0.1), radius: 10, y: -5)
                    .ignoresSafeArea(.container, edges: .bottom) // Pega el fondo al borde
            )
            
            // 2. El Botón Modal (Central)
            Button(action: onModalButtonTap) {
                Image(systemName: "plus")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(AppColors.Light.background)
                    .padding(18)
                    .background(AppColors.Light.primary)
                    .clipShape(Circle())
                    .shadow(color: AppColors.Light.shadow.opacity(0.3), radius: 10, y: 5)
            }
            // Elevamos el botón para que se asome
            .offset(y: -25)
        }
        .frame(height: 70) // Altura total del componente
    }
}
