import Foundation
internal import Combine

@MainActor // Asegura que los @Published se actualicen en el hilo principal
class DashboardViewModel: ObservableObject {
    
    // 1. Propiedades de la Vista
    @Published var quote: Mensaje?
    @Published var tip: Consejo?
    
    // 2. Estados de Carga (ya no se carga el usuario/racha)
    @Published var quoteLoading: Bool = true
    @Published var tipLoading: Bool = true
    
    // 3. Dependencias (¡CAMBIO!)
    // private let fetchUsuarioUseCase: FetchUsuarioUseCase // <-- ESTO SE FUE
    private let fetchMensajesUseCase: FetchMensajesUseCase
    private let fetchConsejoUseCase: FetchConsejoUseCase
    private let authService: AuthService // <-- ESTA ES LA NUEVA

    // 4. Propiedad Computada (¡NUEVO!)
    // La Vista leerá la racha desde aquí
    var racha: Racha? {
        guard let rachaDTO = authService.usuario?.racha else { return nil }
        // Mapeamos del DTO a nuestro modelo de Dominio
        return Racha(
            actual: rachaDTO.actual,
            mejor: rachaDTO.mejor,
            ultimaActividad: Date() // TODO: Convertir la fecha del DTO
        )
    }
    
    // Exponer el nombre del usuario para la vista
    var userName: String? {
        authService.usuario?.nombre
    }
    
    private var cancellables = Set<AnyCancellable>()

    // 5. Inicializador (¡CAMBIO!)
    init(
        fetchMensajesUseCase: FetchMensajesUseCase,
        fetchConsejoUseCase: FetchConsejoUseCase,
        authService: AuthService // Se inyecta el AuthService
    ) {
        self.fetchMensajesUseCase = fetchMensajesUseCase
        self.fetchConsejoUseCase = fetchConsejoUseCase
        self.authService = authService
        
        // Nos suscribimos a cambios en AuthService.
        // Si el usuario cambia (ej. al hacer login),
        // esta vista se actualizará automáticamente.
        authService.$usuario
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    // 6. Función de carga (¡CAMBIO!)
    func loadData() async {
        // Ya no llamamos a loadUsuario()
        self.quoteLoading = true
        self.tipLoading = true
        
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadQuote() }
            group.addTask { await self.loadTip() }
        }
    }
    
    // La función 'loadUsuario()' se eliminó por completo

    private func loadQuote() async {
        do {
            let mensajes = try await fetchMensajesUseCase.execute()
            self.quote = mensajes.randomElement()
        } catch {
            print("Error cargando mensajes: \(error)")
            self.quote = nil
        }
        self.quoteLoading = false
    }
    
    private func loadTip() async {
        do {
            let consejos = try await fetchConsejoUseCase.execute()
            self.tip = consejos.randomElement()
        } catch {
            print("Error cargando consejos: \(error)")
            self.tip = nil
        }
        self.tipLoading = false
    }
}
