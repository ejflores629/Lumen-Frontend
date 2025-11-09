// MARK: - Presentation/ViewModels/LoginViewModel.swift
import Foundation
internal import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    // --- 1. Propiedades para la Vista ---
    @Published var correo: String = ""
    @Published var nombre: String = ""
    @Published var estado: EstadoLogin = .idle
    @Published var errorMensaje: String?
    
    // Modo de la pantalla: .login o .registro
    @Published var modo: ModoLogin = .login
    
    // --- 2. Enums Internos ---
    enum ModoLogin {
        case login
        case registro
    }
    
    enum EstadoLogin {
        case idle
        case cargando
    }
    
    // --- 3. Dependencias ---
    private let authService: AuthService
    
    // --- 4. Inicializador ---
    init(authService: AuthService) {
        self.authService = authService
    }
    
    // --- 5. Lógica de Acción (con logs mejorados) ---
    func procesarAccion() async {
        
        // Validación
        guard !correo.isEmpty else {
            errorMensaje = "El correo no puede estar vacío"
            return
        }
        
        if modo == .registro && nombre.isEmpty {
            errorMensaje = "El nombre no puede estar vacío"
            return
        }
        
        estado = .cargando
        errorMensaje = nil
        
        do {
            if modo == .login {
                try await authService.login(correo: correo)
            } else {
                try await authService.registrar(correo: correo, nombre: nombre)
            }
            // Si el 'try' tiene éxito, el AuthService actualizará su
            // @Published var token, y el 'Lumen.swift' (punto de entrada)
            // detectará ese cambio y mostrará el ContentView.
            
        } catch {
            // --- INICIO DE LOGS MEJORADOS ---
            
            // 1. Imprimir el error DETALLADO en la consola de Xcode
            print("\n--- ¡ERROR EN LOGIN VIEW MODEL! ---")
            print("Modo: \(modo == .login ? "Login" : "Registro")")
            print("Correo: \(correo)")
            print("Error al procesar acción:")
            print(error) // Imprime el error completo (URLError, DecodingError, etc.)
            print("Descripción Localizada: \(error.localizedDescription)")
            print("--- FIN DEL ERROR ---")

            // 2. Mostrar un mensaje de error más útil en la app
            let nsError = error as NSError
            if nsError.domain == "AuthError" {
                // Este es nuestro error personalizado de ApiUsuarioRepository
                // (ej. "Usuario no encontrado" o "El usuario ya existe")
                errorMensaje = nsError.localizedDescription
            } else if let urlError = error as? URLError {
                errorMensaje = "Error de red: \(urlError.localizedDescription)"
            } else if error is DecodingError {
                errorMensaje = "Error al leer la respuesta del servidor."
            } else {
                errorMensaje = "Error inesperado: \(nsError.localizedDescription)"
            }
            
            // --- FIN DE LOGS MEJORADOS ---
        }
        
        estado = .idle // Terminamos la carga
    }
    
    // --- 6. Función Auxiliar ---
    func cambiarModo() {
        modo = (modo == .login) ? .registro : .login
        errorMensaje = nil
    }
}
