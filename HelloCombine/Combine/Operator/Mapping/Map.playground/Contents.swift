import UIKit
import Combine

enum MyError: Error {
    case anyError
}

let publisher = [1, 2, 3, 4].publisher
let passthroughSubject = PassthroughSubject<Int, MyError>()

publisher
    .setFailureType(to: MyError.self)
    .combineLatest(passthroughSubject)
    .sink { completion in
        print("Recevied Completion: \(completion)")
    } receiveValue: { value in
        print("Received Value: \(value)")
    }

passthroughSubject.send(0)
