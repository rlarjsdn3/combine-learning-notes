import UIKit
import Combine

//: # Fail
//: Fail은 곧바로 Error 항목을 방출하는 Publisher입니다. Completion 항목은 방출하지 않습니다.

var cancellable = Set<AnyCancellable>()

enum MyError: Error {
    case null
}

Fail<Int, MyError>(error: MyError.null)
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

