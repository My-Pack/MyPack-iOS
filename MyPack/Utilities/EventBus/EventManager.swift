//
//  EventManager.swift
//  MyPack
//
//  Created by jito on 2023/03/30.
//

import Foundation

class EventManager {
    static let shared = EventManager()

    private var eventListeners: [String: [(Any) -> Void]] = [:]

    private init() {}

    func addObserver<T>(for event: String, listener: @escaping (T) -> Void) {
        let typeErasedListener: (Any) -> Void = { value in
            if let value = value as? T {
                listener(value)
            } else {
                assertionFailure("Incorrect data type received for event: \(event)")
            }
        }

        if eventListeners[event] == nil {
            eventListeners[event] = []
        }
        eventListeners[event]?.append(typeErasedListener)
    }

    func removeObserver(for event: String) {
        eventListeners.removeValue(forKey: event)
    }

    func post<T>(event: String, data: T) {
        eventListeners[event]?.forEach { listener in
            listener(data)
        }
    }
}
