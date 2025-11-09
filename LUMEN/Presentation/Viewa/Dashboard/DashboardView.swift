// MARK: - Presentation/Views/Dashboard/DashboardView.swift
import SwiftUI

struct DashboardView: View {
    
    // El ViewModel se inyectará (esto está bien)
    @StateObject var vm: DashboardViewModel

    var body: some View {
        ZStack {
            AppColors.Light.backgroundSecondary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ... Tu Header (sin cambios) ...
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hola")
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.Light.textSecondary)
                    // ¡NUEVO! Leemos el nombre del usuario desde el VM
                    Text(vm.userName ?? "¿Cómo te sientes hoy?")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(AppColors.Light.text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 20)
                .background(AppColors.Light.background)
                .overlay(
                    Rectangle().frame(height: 1).foregroundColor(AppColors.Light.cardBorder), alignment: .bottom
                )
                
                // Content Scroll
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // --- INICIO DE LA CORRECCIÓN ---
                        StreakSectionView(
                            // 1. Pasamos la propiedad computada 'vm.racha'
                            streak: vm.racha
                            // 2. Ya no pasamos 'isLoading'
                        )
                        // --- FIN DE LA CORRECCIÓN ---
                        
                        QuoteSectionView(
                            quote: vm.quote,
                            isLoading: vm.quoteLoading
                        )
                        
                        TipSectionView(
                            tip: vm.tip,
                            isLoading: vm.tipLoading
                        )
                        
                        // (Recuerda que el CTASectionView se eliminó)
                        
                    }
                    // Ajustamos el padding para la barra de menú personalizada
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16) // Padding inferior normal
                }
            }
        }
        .onAppear {
            Task {
                // loadData() ahora solo carga 'quote' y 'tip'
                await vm.loadData()
            }
        }
    }
}
