// MARK: - Presentation/Views/Login/LoginView.swift
import SwiftUI

struct LoginView: View {
    
    // Recibe el ViewModel inyectado
    @StateObject var vm: LoginViewModel
    
    var body: some View {
        ZStack {
            // Fondo
            AppColors.Light.backgroundSecondary.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Título
                Text(vm.modo == .login ? "Bienvenido de Nuevo" : "Crea tu Cuenta")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(AppColors.Light.text)
                
                Text(vm.modo == .login ? "Inicia sesión para continuar" : "Únete a Lumen para tu bienestar")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.Light.text)
                // Campos de Texto
                VStack(spacing: 16) {
                    TextField("Correo Electrónico", text: $vm.correo)
                        .padding(16)
                        .background(AppColors.Light.background)
                        .cornerRadius(12)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(AppColors.Light.text)
                    if vm.modo == .registro {
                        TextField("Tu Nombre", text: $vm.nombre)
                            .padding(16)
                            .background(AppColors.Light.background)
                            .cornerRadius(12)
                            .textInputAutocapitalization(.words)
                            .foregroundColor(AppColors.Light.text)                    }
                }
                
                // Mensaje de Error
                if let error = vm.errorMensaje {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                // Botón de Acción
                Button(action: {
                    Task { await vm.procesarAccion() }
                }) {
                    HStack {
                        Spacer()
                        if vm.estado == .cargando {
                            ProgressView()
                                .tint(AppColors.Light.background)
                        } else {
                            Text(vm.modo == .login ? "Iniciar Sesión" : "Registrarse")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppColors.Light.background)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .background(AppColors.Light.primary)
                    .cornerRadius(12)
                }
                .disabled(vm.estado == .cargando)
                
                Spacer()
                
                // Botón para cambiar de modo
                Button(action: vm.cambiarModo) {
                    Text(vm.modo == .login ? "¿No tienes cuenta? Regístrate" : "¿Ya tienes cuenta? Inicia Sesión")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(AppColors.Light.primary)
                }
            }
            .padding(24)
        }
    }
}
