import UIKit
import Combine

Just(7)
    .sink { completion in
        print("Recevied Completion: \(completion)")
    } receiveValue: { value in
        print("Received Value: \(value)")
    }

