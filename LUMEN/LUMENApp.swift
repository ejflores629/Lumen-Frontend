import SwiftUI

@main
struct Lumen: App {

    // --- Repositorios ---
    private static let mensajeRepo = ApiMensajeRepository()
    private static let consejoRepo = ApiConsejoRepository()
    private static let usuarioRepo = ApiUsuarioRepository()
    private static let emocionRepo = ApiEmocionRepository()
    private static let chatRepo = ApiChatRepository() // ¡Está de vuelta!

    // --- Casos de Uso ---
    private static let fetchMensajesUC = FetchMensajesUseCase(repository: mensajeRepo)
    private static let fetchConsejoUC = FetchConsejoUseCase(repository: consejoRepo)
    private static let fetchHistorialUC = FetchHistorialEmocionesUseCase(repository: emocionRepo)

    
    // --- Servicios y ViewModels ---
    @StateObject private var authService: AuthService
    @StateObject private var dashboardViewModel: DashboardViewModel
    @StateObject private var loginViewModel: LoginViewModel

    init() {
        let auth = AuthService(usuarioRepository: Lumen.usuarioRepo)
        _authService = StateObject(wrappedValue: auth)
        
        _dashboardViewModel = StateObject(wrappedValue: DashboardViewModel(
            fetchMensajesUseCase: Lumen.fetchMensajesUC,
            fetchConsejoUseCase: Lumen.fetchConsejoUC,
            authService: auth
        ))
        
        _loginViewModel = StateObject(wrappedValue: LoginViewModel(
            authService: auth
        ))
    }

    var body: some Scene {
        WindowGroup {
            if authService.token != nil && authService.usuario != nil {
                // Si estamos logueados, mostramos ContentView
                ContentView(
                    dashboardViewModel: dashboardViewModel,
                    authService: authService,
                    emocionRepo: Lumen.emocionRepo,
                    chatRepo: Lumen.chatRepo, // ¡Lo pasamos a la vista!
                    fetchHistorialUC: Lumen.fetchHistorialUC
                )
            } else {
                // Si no, mostramos Login
                LoginView(vm: loginViewModel)
            }
        }
    }
}
