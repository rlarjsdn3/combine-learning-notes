import UIKit
import Combine

//: # SetFailureType
//: 에러가 담긴 항목을 방출하지 않는(Never) 업스트림 `Publisher`의 Failure 타입을 바꾸는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case null
}

let publisher = Just("Hello, Combine")
    .setFailureType(to: CombineError.self)
    .eraseToAnyPublisher()
// AnyPublisher<Result<String, CombineError>.Publisher.Output, CombineError>
