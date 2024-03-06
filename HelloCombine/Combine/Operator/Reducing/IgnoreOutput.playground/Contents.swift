import UIKit
import Combine

//: # IgnoreOutput
//: 업스트림 `Publisher`가 방출하는 모든 항목을 무시하는 Publisher입니다. 하지만 Completion 항목(Finished 혹은 Failure)은 방출합니다.

var cancellable = Set<AnyCancellable>()

Array(1...100).publisher
    .ignoreOutput()
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

