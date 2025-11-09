import Foundation

class ApiUsuarioRepository: ApiService, UsuarioRepository {
    
    func login(correo: String) async throws -> LoginResponse {
        guard let url = URL(string: "\(baseURL)/usuarios/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(LoginRequest(correo: correo))
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // TODO: Manejar 404 (Usuario no encontrado)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse) // Simplificado
        }

        // Decodificamos la respuesta de Login
        let loginResponse = try snakeCaseDecoder.decode(LoginResponse.self, from: data)
        return loginResponse
    }
    
    func registrar(correo: String, nombre: String) async throws {
        guard let url = URL(string: "\(baseURL)/usuarios/registrar") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try snakeCaseEncoder.encode(UsuarioInput(correo: correo, nombre: nombre))
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
        // No devuelve nada, solo éxito
    }
}
