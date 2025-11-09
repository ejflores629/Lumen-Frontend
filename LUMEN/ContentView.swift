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
                    // Pantalla placeholder para "Perfil"
                    VStack(spacing: 12) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 60))
                            .foregroundColor(AppColors.Light.textTertiary)
                        Text("Pantalla de Perfil")
                            .font(.title)
                        Text("Aquí podrás cerrar sesión.")
                            .foregroundColor(AppColors.Light.textSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
