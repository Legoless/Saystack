//
//  AsyncBlockOperation.swift
//  Saystack
//
//  Created by Dal Rupnik on 12/09/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

import Foundation

public typealias AsyncBlock = (AsyncOperation) -> Void

open class AsyncBlockOperation : AsyncOperation {
    
    private(set) var executionBlocks : [AsyncBlock] = []
    private var completedCount = 0
    
    public convenience init(block: @escaping AsyncBlock) {
        self.init()
        
        executionBlocks.append(block)
    }
    
    open func addExecutionBlock(_ block: @escaping AsyncBlock) {
        if isExecuting {
            fatalError("Unable to add execution block to executing operations.")
        }
        
        executionBlocks.append(block)
    }
    
    open override func main() {
        //
        // Run all blocks and wait for them to finish.
        //
        for block in executionBlocks {
            block(self)
        }
    }
    
    open override func complete() {
        completedCount += 1
        
        //
        // Each block must call this method. As soon as all blocks did call it, operation is completed.
        //
        if completedCount == executionBlocks.count {
            super.complete()
        }
    }
}
