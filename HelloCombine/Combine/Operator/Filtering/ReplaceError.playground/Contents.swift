import UIKit
import Combine

//: # ReplaceErro
//: 업스트림 `Publisher`가 방출한 에러가 담긴 항목을 다른 대체 항목으로 바꿔주는 Publisher입니다. (그래도 스트림은 중단됩니다)

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case invalidFormat
}

["1", "a", "2"].publisher
    .tryCompactMap { value -> Int? in
        guard let value = Int(value) else {
            throw CombineError.invalidFormat
        }
        return value
    }
    .replaceError(with: -1)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
