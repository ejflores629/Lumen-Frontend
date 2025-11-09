// MARK: - Presentation/Views/Registration/EmotionRegistrationModal.swift
import SwiftUI

struct EmotionRegistrationModal: View {
    
    // 1. Acepta el ViewModel inyectado
    @StateObject var vm: EmotionRegistrationViewModel
    
    // 2. Acepta la acción para cerrar el modal
    let dismissAction: () -> Void
    
    // 3. El init ahora es simple
    init(vm: EmotionRegistrationViewModel, dismissAction: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: vm)
        self.dismissAction = dismissAction
    }

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(step: vm.currentStep, closeAction: dismissAction)
            
            VStack {
                switch vm.currentStep {
                case 1:
                    Step1View(selectedEmotion: $vm.selectedEmotion)
                case 2:
                    Step2View(note: $vm.note, noteUpdater: { vm.note = $0 })
                case 3:
                    Step3View(
                        isPending: vm.isPending,
                        aiResponse: vm.aiResponse,
                        finishAction: dismissAction // Usa la acción
                    )
                default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(24)
            .background(AppColors.Light.background)
            
            if vm.currentStep < 3 {
                FooterView(
                    step: vm.currentStep,
                    canProceed: vm.canProceed,
                    handleBack: vm.handleBack,
                    handleNext: vm.handleNext
                )
            }
        }
        .background(AppColors.Light.background.ignoresSafeArea())
    }
}
