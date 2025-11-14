// MARK: - Presentation/Views/ContentView.swift
import SwiftUI

struct ContentView: View {
 
    @StateObject var dashboardViewModel: DashboardViewModel
    
    // Recibimos todas las dependencias
    let authService: AuthService
    let emocionRepo: EmocionRepository
    let chatRepo: ChatRepository // ¡El chat está de vuelta!
    let fetchHistorialUC: FetchHistorialEmocionesUseCase

    @State private var selectedTab: Tab = .hoy
    @State private var showingRegistrationModal: Bool = false

    // Ahora tenemos 4 pestañas reales
    enum Tab: Int {
        case hoy
        case historial
        case asistente
        case perfil
    }

    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                // El contenido cambia según la pestaña
                switch selectedTab {
                case .hoy:
                    DashboardView(vm: dashboardViewModel)
                
                case .historial:
                    HistorialView(
                        vm: HistorialViewModel(
                            useCase: fetchHistorialUC,
                            authService: authService
                        )
                    )
                
                case .asistente:
                    // ¡El chat está de vuelta!
                    ChatView(
                        vm: ChatViewModel(
                            chatRepository: chatRepo,
                            authService: authService
                        )
                    )
                    
                case .perfil:
                                    VStack(spacing: 0) {
                                        // 1. Cabecera
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Tu Perfil")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundColor(AppColors.Light.text)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 24)
                                        .padding(.top, 16)
                                        .padding(.bottom, 20)
                                        .background(AppColors.Light.background)
                                        .overlay(
                                            Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder),
                                            alignment: .bottom
                                        )
                                        
                                        VStack(alignment: .leading, spacing: 24) {
                                            // Usamos el usuario del AuthService
                                            if let usuario = authService.usuario {
                                                
                                                // Tarjeta de datos
                                                VStack(alignment: .leading, spacing: 16) {
                                                    HStack {
                                                        Text("Nombre:").foregroundColor(AppColors.Light.textSecondary)
                                                        Spacer()
                                                        Text(usuario.nombre)
                                                            .foregroundColor(AppColors.Light.text)
                                                            .fontWeight(.semibold)
                                                    }
                                                    Divider()
                                                    HStack {
                                                        Text("Correo:").foregroundColor(AppColors.Light.textSecondary)
                                                        Spacer()
                                                        Text(usuario.correo)
                                                            .foregroundColor(AppColors.Light.text)
                                                            .fontWeight(.semibold)
                                                    }
                                                }
                                                .padding(20)
                                                .background(AppColors.Light.card)
                                                .cornerRadius(16)
                                                .shadow(color: AppColors.Light.shadow.opacity(0.1), radius: 5, y: 2)
                                                
                                            } else {
                                                Text("No se pudo cargar la información del usuario.")
                                            }
                                            
                                            Spacer() // Empuja el botón hacia abajo

                                            // Botón de Cerrar Sesión
                                            Button(action: {
                                                authService.logout() // Llama a la función de logout
                                            }) {
                                                HStack {
                                                    Spacer()
                                                    Text("Cerrar Sesión")
                                                        .font(.system(size: 16, weight: .semibold))
                                                        .foregroundColor(.red) // Color de peligro
                                                    Spacer()
                                                }
                                                .padding(.vertical, 14)
                                                .background(AppColors.Light.card)
                                                .cornerRadius(12)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.red.opacity(0.4), lineWidth: 1)
                                                )
                                            }
                                        }
                                        .padding(24)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                                    }
                                    .background(AppColors.Light.backgroundSecondary.ignoresSafeArea())
                                    // --- FIN DE LA MODIFICACIÓN ---
                                }
                            }
                            .padding(.bottom, 80)

            
            // La barra personalizada ahora maneja las 4 pestañas + modal
            CustomTabBar(
                selectedTab: $selectedTab,
                onModalButtonTap: {
                    showingRegistrationModal = true
                }
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .sheet(isPresented: $showingRegistrationModal) {
            EmotionRegistrationModal(
                vm: EmotionRegistrationViewModel(
                    emocionRepository: emocionRepo,
                    authService: authService
                ),
                dismissAction: {
                    showingRegistrationModal = false
                }
            )
        }
        .background(AppColors.Light.backgroundSecondary.ignoresSafeArea())
    }
}
