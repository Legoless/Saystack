//
//  Timer+MainActor.swift
//  Saystack
//
//  Created by Dal Rupnik on 08.09.2025.
//

import Foundation

public extension Timer {

    @MainActor
    static func scheduled(
        with timeInterval: Double,
        repeats: Bool,
        block: @escaping @MainActor () -> Void
    ) -> Timer {
        return scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: { _ in
            Task { @MainActor in block() }
        })
    }
}
