import UIKit
import Combine

//: # Combine
/*:
 Combine 프레임워크는 219년 애플에서 발표한 순차적 비동기 이벤트 처리를 위한 선언적 프레임워크입니다. 시간의 흐름에 따라 항목을 방출하는 `Publisher`와 `Publisher`로부터 이를 전달받는 `Subscriber`가 있으며, 이 둘 사이를 이어주는 `Subscription`이 존재합니다.
 */
//: ## `비동기 이벤트`란 무엇일까요?
/*:
 ① 버튼을 탭하거나 ② 키보드가 올라오거나 ③ 네트워크 결과를 받아오는 등 UI 반응이나 로직의 결과물이 모두 `비동기 이벤트`가 될 수 있습니다.
 
 그런데 굉장히 이상하죠. `버튼을 탭하는` 행위는 보통 메인 쓰레드에서 처리됩니다. 이것이 `비동기 이벤트`로 어떻게 설명될 수 있을까요? 여기서 조금 다른 시각이 필요합니다. Combine 프레임워크에서는 버튼 탭을 감지하기 위한 시스템이 `비동기`적으로 동작합니다. 버튼을 탭하면 이에 대한 반응은 `동기`적 (경우에 따라서 `비동기`적)으로 일어납니다. 이 둘은 구분해서 이해할 필요가 있습니다.

 조금 더 깊게 이해해봅시다. 만약 Combine 프레임워크가 `동기 이벤트` 처리를 하게 되면 무슨 일이 벌어질까요? 아마 화면 간에 이벤트를 전달받는 과정에서 수 많은 블로킹이 발생할 겁니다. 이는 UI 반응성을 떨어뜨리고, 사용자 경험을 저해하는 결과를 저하시킬 수 있습니다. 따라서 이벤트는 `비동기`로 처리하는 게 중요하며, 이를 통해 빠른 응답성과 높은 사용자 경험이라는 두 마리 토끼를 모두 잡을 수 있습니다.
 */
//: ## `Publisher`, `Subscriber` 맛보기
/*:
 `Publisher`와 `Subsriber`의 역할을 간단하게 설명하면 아래와 같습니다.
 * `Publisher`는 시간의 흐름에 따라 하나 혹은 여러 개로 구성된 일련의 항목을 `Subscrbier`에 방출할 수 있습니다. `Publisher`는 `Operators`를 가지며 업스트림 `Publisher`로부터 항목을 받아 가공해 재방출할 수 있습니다.
 * `Publisher` 체인의 끝에는 `Subscriber`가 항목을 전달받습니다. `Publisher`는 `Subscriber`가 항목을 요청할 때만 항목을 방출합니다. 이는 `Subscriber`가 `Publisher`로부터 얼마나 많이 항목을 전달받을지 컨트롤할 수 있게 합니다.
 */

/*:
 Combine 프레임워크는 개발자가 비동기 코드를 깔금하게 작성하도록 도와줍니다. Combine 프레임워크를 사용하지 않더라도 Delegate 패턴, 콜백 클로저로 하여 비동기 처리를 해줄 수 있지만, 코드의 깊이가 너무 깊어지고 예외 처리가 까다로워진다는 단점이 있습니다. Combine 프레임워크를 이런 문제를 손쉽게 해결할 수 있는 솔루션 중 하나입니다.

 UI 반응 로직도 단순해집니다. 복잡한 Target-Action 패턴으로 반응을 처리할 필요가 없어지죠. 예를 들어, 텍스트 필드를 `Publisher`로 만들고, 이를 `Subscriber`가 구독해 사용자의 타이핑을 관찰하고, 네트워크 통신 등 로직을 수행하게 할 수 있습니다. 그리고 또 다른 `Publisher`가 (로직의 결과인) 항목을 방출해 UI를 업데이트하도록 할 수 있습니다.

 이렇듯, Combine 프레임워크는 중첩된 클로저와 콜백과 같은 문제 소지가 다분한 코드를 지양하고, 직관적이고 가독성 높은 코드 작성을 가능케 해주어 유지 보수를 쉽게 만들어준다는 장점이 있습니다.
 */



