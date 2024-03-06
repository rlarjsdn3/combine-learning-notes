import UIKit
import Combine

//: # CompactMap
//: 업스트림 `Publisher`가 방출하는 항목이 nil이 아니면 (옵셔널 해제가 가능하면) 다운스트림으로 내려보내는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case invalidFormat
}

["1", "2", "3", "4", "z"].publisher
    .tryCompactMap { value in
        guard let value = Int(value) else {
            throw CombineError.invalidFormat
        }
        return value
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)
