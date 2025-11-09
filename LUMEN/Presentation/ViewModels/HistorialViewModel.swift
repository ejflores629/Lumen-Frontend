// MARK: - Presentation/ViewModels/HistorialViewModel.swift
import Foundation
internal import Combine

@MainActor
class HistorialViewModel: ObservableObject {
    
    @Published var emociones: [APIEmocion] = []
    @Published var estado: EstadoCarga = .idle
    
    enum EstadoCarga: Equatable {
        case idle
        case cargando
        case exito
        case error(String)
    }
    
    private let fetchHistorialUseCase: FetchHistorialEmocionesUseCase
    private let authService: AuthService
    
    init(useCase: FetchHistorialEmocionesUseCase, authService: AuthService) {
        self.fetchHistorialUseCase = useCase
        self.authService = authService
    }
    
    func cargarHistorial() async {
        guard let token = authService.token else {
            estado = .error("No estás autenticado.")
            return
        }
        
        estado = .cargando
        
        do {
            let historial = try await fetchHistorialUseCase.execute(token: token)
            self.emociones = historial
            self.estado = .exito
            
        } catch {
            // --- ¡LOG MEJORADO! ---
            // Imprime el error real en la consola de Xcode
            print("\n--- ¡ERROR EN HISTORIAL VIEW MODEL! ---")
            print("Error al llamar a fetchHistorialUseCase.execute:")
            print(error) // Imprime el error completo (ej. -1011)
            print("--- FIN DEL ERROR ---")
            
            // Muestra el error en la UI
            self.estado = .error("Error: \(error.localizedDescription)")
        }
    }
}
