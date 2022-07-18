import Foundation
import RxSwift


/**
 * Observable의 정의 목록
 */
print("Just")
Observable<Int>.just(1) //하나의 엘레멘트만 방출하는 시퀀스를 생성(Just Operator를 통해)
    .subscribe(onNext:{ //Obervable들은 Subscribe돼야지만 동작함, Subscribe해야 그 흐름을 볼 수 있다.
        print($0)
    })
print("Of1")
Observable<Int>.of(1,2,3,4,5) //여러개 엘레멘트를 방출하는 시퀀스를 생성(of Operator를 통해)
    .subscribe(onNext : {
        print($0)
    })
print("Of2")
Observable.of([1,2,3,45]) //Observable의 타입 추론도 가능
    .subscribe(onNext : {
        print($0)
    })
print("From")
Observable.from([1,2,3,4]) //From Operator는 배열을 인자로 받고 각 요소를 하나씩 방출
    .subscribe(onNext : {
        print($0)
    })

print("------subscribe 흐름 표시------")
Observable.of(1,2,3)
    .subscribe{ //onNext이벤트를 정의 안해줘도 알아서 Next이벤트를 실행하고 완료시킴. (소스코드 실행해보셈)
        print($0)
    }

print("------subscribe 의 다른 표현식, OnNext 말고 If Let방식을 이용한 값 핸들링------")
Observable.of(1,2,3)
    .subscribe{
        if let element = $0.element{ //OnNext 정의없이 OnNext이벤트의 엘레멘트를 가져오기
            print(element)
        }
    }

print("------empty 타입추론------")
Observable.empty()
    .debug("never")
    .subscribe{
        print($0)
    }
print("------empty 타입추론 X------")
Observable<Void>.empty()
    .debug("never")
    .subscribe{
        print($0)
    }
print("------Never------") //complete 이벤트도 실행되지 않음
Observable.never()
    .debug("never") //debug를 통해 흐름을 파악할 수 있음
    .subscribe{
        print($0)
    }

print("------range------")
Observable.range(start: 1, count: 9)
    .subscribe{
        print($0)
    }

print("------dispose------")
Observable.of(1,2,3)
    .subscribe(onNext:{
        print($0)
    })

