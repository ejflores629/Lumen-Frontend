
// MARK: - Presentation/Views/Historial/HistorialView.swift
import SwiftUI

struct HistorialView: View {
    
    @StateObject var vm: HistorialViewModel
    
    var body: some View {
        ZStack {
            AppColors.Light.backgroundSecondary.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. Cabecera (similar a la de Chat)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Tu Historial")
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
                
                // 2. Contenido
                switch vm.estado {
                case .idle, .cargando:
                    ProgressView("Cargando historial...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .exito:
                    if vm.emociones.isEmpty {
                        Text("Aún no tienes emociones registradas.")
                            .foregroundColor(AppColors.Light.textSecondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // La lista de emociones
                        List(vm.emociones, id: \._id) { emocion in
                            EmotionRowView(emocion: emocion)
                                .listRowInsets(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                                .listRowSeparator(.hidden)
                                .listRowBackground(AppColors.Light.backgroundSecondary)
                        }                    }
                    
                case .error(let mensaje):
                    // ¡Aquí veremos el error de autenticación si falla!
                    VStack(spacing: 12) {
                        Image(systemName: "xmark.octagon.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text("Error al Cargar")
                            .font(.headline)
                        Text(mensaje)
                            .font(.caption)
                            .foregroundColor(AppColors.Light.textSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .onAppear {
            // Cargamos los datos solo la primera vez que aparece
            if vm.estado == HistorialViewModel.EstadoCarga.idle {
                Task {
                    await vm.cargarHistorial()
                }
            }
        }
    }
}

