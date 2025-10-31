//
//  ContentView.swift
//  sandbox
//
//  Created by Sergey Kozlov on 01.10.2025.
//

import SwiftUI

enum Mirror_KVC {
    @objcMembers
    @MainActor
    class Base: NSObject {
        var str = "my string"
        
        // Обязательный инициализатор, чтобы его можно было вызывать как self.init() из методов, возвращающих Self.
        required override init() {
            super.init()
        }
        
        // MARK: - Encoding
        
        func encodedData() -> Data? {
            var dict: [String: Any] = [:]
            
            var current: Mirror? = Mirror(reflecting: self)
            while let mirror = current {
                for child in mirror.children {
                    guard let key = child.label else { continue }
                    if dict[key] == nil {
                        // Берём значение через KVC, чтобы фактически попадали только хранимые KVC-совместимые свойства
                        let kvcValue = SafeKVC.value(forKey: key, of: self)
                        if let v = kvcValue {
                            dict[key] = v
                        } else {
                            // Если KVC недоступна — можно было бы fallback на Mirror, но вы хотите только хранимые
                            // dict[key] = child.value
                        }
                    }
                }
                current = mirror.superclassMirror
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted])
                return data
            } catch {
                print("JSONSerialization error: \(error)")
                return nil
            }
        }
        
        // MARK: - Decoding (apply to existing instance)
        
        /// Применяет значения из JSON к уже существующему объекту.
        /// Это "апдейт", а не создание, поэтому метод назван соответствующе.
        private func applyDecodedValues(from data: Data) {
            guard
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let dict = json as? [String: Any]
            else {
                print("applyDecodedValues: invalid JSON payload")
                return
            }
            
            // Собираем ключи свойств (включая суперклассы)
            var keys: Set<String> = []
            var mirrors: [Mirror] = []
            var current: Mirror? = Mirror(reflecting: self)
            while let m = current {
                mirrors.append(m)
                current = m.superclassMirror
            }
            for mirror in mirrors {
                for child in mirror.children {
                    if let key = child.label {
                        keys.insert(key)
                    }
                }
            }
            
            // Устанавливаем только известные свойства
            for key in keys {
                guard let rawValue = dict[key] else { continue }
                
                // Минимально необходимая нормализация для KVC:
                // - NSNull -> nil (важно для опционалов)
                // - остальное передаём как есть (String пробриджится в NSString, числа уже NSNumber)
                let normalized: Any?
                if rawValue is NSNull {
                    normalized = nil
                } else {
                    normalized = rawValue
                }
                
                _ = SafeKVC.setValue(normalized, forKey: key, of: self)
            }
        }
        
        // MARK: - Factory decode (create new instance)
        
        /// Создаёт новый экземпляр и применяет к нему данные из JSON.
        /// Такой API ближе к привычному Decodable.
        static func decoded(from data: Data) -> Self? {
            let obj = self.init()
            obj.applyDecodedValues(from: data)
            return obj
        }
    }
    
    
    @MainActor
    class Derived: Base {
        var number = 10
        // Так как init в Base помечен required, здесь нужно required override.
        required init() {
            super.init()
        }
    }
    
    struct ContentView: View {
        var body: some View {
            VStack {
                Text("Hello, world!")
                Button("Press") {
                    let derived = Derived()
                    derived.number = 100
                    derived.str = "new str"
                    
            
                    guard let data = derived.encodedData(),
                          let jsonString = String(data: data, encoding: .utf8) else { return }
                    print("Encoded:\n\(jsonString)")
                    
                    if let newDerived = Derived.decoded(from: data),
                       let newData = newDerived.encodedData(),
                       let newJsonString = String(data: newData, encoding: .utf8) {
                        print("Re-encoded:\n\(newJsonString)")
                    }
                }
            }
            .padding()
        }
    }
    
}
