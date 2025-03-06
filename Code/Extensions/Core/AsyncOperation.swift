//
//  AsyncOperation.swift
//  Saystack
//
//  Created by Dal Rupnik on 12/09/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

import Foundation


open class AsyncOperation : Operation, @unchecked Sendable {
    private var _executing : Bool = false
    private var _finished : Bool = false
    private var _cancelled: Bool = false
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    open override var isExecuting : Bool {
        return _executing
    }
    
    open override var isFinished : Bool {
        return _finished
    }
    
    open override var isCancelled: Bool {
        return _cancelled
    }
    
    open override func start() {
        if isCancelled {
            return
        }
        
        willChangeValue(forKey: "isExecuting")
        Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
        self._executing = true
        didChangeValue(forKey: "isExecuting")
    }
    
    open func complete() {
        willChangeValue(forKey: "isFinished")
        willChangeValue(forKey: "isExecuting")
        
        _executing = false
        _finished = true
        
        didChangeValue(forKey: "isExecuting")
        didChangeValue(forKey: "isFinished")
    }
    
    open override func cancel() {
        willChangeValue(forKey: "isCancelled")
        _cancelled = true
        didChangeValue(forKey: "isCancelled")
        
        complete()
    }
}
