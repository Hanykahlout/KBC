//
//  AuthManager.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/9/24.
//



import Foundation
import LocalAuthentication

class AuthManager {
    static let shared = AuthManager()
    
    static var goToHome:(()->Void)?
    
    private init() {}
    
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        
//        if let storedHash = UserDefaults.standard.string(forKey: "SharedPref.hash") {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: "Authenticate to access the app"
                ) { success, error in
                    DispatchQueue.main.async {
                        completion(success)
                    }
                }
            } else {
                // Fallback to password authentication
//                authenticateWithPassword(storedHash: storedHash, completion: completion)
            }
//        } else {
//            completion(true)
//        }
        
    }
    
    private func authenticateWithPassword(storedHash: String, completion: @escaping (Bool) -> Void) {
        // Implement password authentication logic here
        // For example, you can show a UIAlertController to prompt for password
        // Then compare the entered password hash with the storedHash
        // Call completion(true) if authentication succeeds, completion(false) otherwise
    }
    
}
