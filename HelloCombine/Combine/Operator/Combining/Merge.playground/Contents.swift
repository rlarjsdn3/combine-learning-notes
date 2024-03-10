import UIKit
import Combine

//: # Merge
//: 업스트림 `Pubilsher`와 결합한 `Publisher`가 방출하는 항목을 하나로 묶은 결과를 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<Int, Never>()
let subject3 = PassthroughSubject<Int, Never>()

subject1
    .merge(with: subject2, subject3)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

subject1.send(1)
subject2.send(40)
subject3.send(90)
subject1.send(2)
subject2.send(50)
subject3.send(100)

subject1.send(completion: .finished)
subject2.send(completion: .finished)
subject3.send(completion: .finished)

//: RxSwift와 유사한 개념: Merge
