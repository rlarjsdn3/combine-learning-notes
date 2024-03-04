import UIKit
import Combine

//: # Just
//: Just는 단 하나의 항목을 방출하는 Publisher입니다. 항목을 방출하면 곧바로 Completion 항목을 방출합니다. 에러를 방출할 수 없습니다.

var cancellable = Set<AnyCancellable>()

Just("Just Publisher")
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

