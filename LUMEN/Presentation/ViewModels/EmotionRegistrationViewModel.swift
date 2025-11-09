// MARK: - Presentation/ViewModels/EmotionRegistrationViewModel.swift
import Foundation
internal import Combine

@MainActor
class EmotionRegistrationViewModel: ObservableObject {
    
    @Published var currentStep: Int = 1
    
    // Bindings para las Vistas
    @Published var selectedEmotion: EmotionType?
    @Published var note: String = ""
    
    // Estado de Carga (para Step 3)
    @Published var isPending: Bool = false
    @Published var aiResponse: String?
    
    var canProceed: Bool {
        switch currentStep {
        case 1: return selectedEmotion != nil
        case 2: return true
        default: return false
        }
    }
    
    private let emocionRepository: EmocionRepository
        private let authService: AuthService
        
    init(emocionRepository: EmocionRepository, authService: AuthService) {
        self.emocionRepository = emocionRepository
        self.authService = authService
    }
    
    func handleNext() {
        if currentStep == 2 {
            Task { await submitEmotion() }
        } else {
            currentStep += 1
        }
    }
    
    func handleBack() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }
    
    private func submitEmotion() async {
        guard let emotionType = selectedEmotion,
              let token = authService.token else { return } // Necesitamos el token
        
        currentStep = 3
        isPending = true
        
        do {
            let input = EmocionInput(
                sentimiento: emotionType.rawValue, // "Feliz", "Mal", etc.
                descripcion: note
            )
            
            // Llamamos al repositorio con el input y el token
            let response = try await emocionRepository.crearEmocion(input: input, token: token)
            
            // Extraemos el mensaje de IA de la nueva respuesta
            self.aiResponse = response.mensajeIA
            
        } catch {
            print("Error al crear emocion: \(error)")
            self.aiResponse = "Lo sentimos, ocurrió un error al generar tu mensaje."
        }
        
        self.isPending = false
    }
}
