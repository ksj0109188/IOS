import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("-------------startWith--------------")
let 노랑반 = Observable<String>.of("응애1","응애2","응애3")

노랑반
    .enumerated()
    .map {index, element in
        return element + "어린이 \(index)"
    }
    .startWith("선생님") // 시퀀스 초기값으로 어느 위치에서든 옵저버에서 제일 첫번째로 등장하게됨
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------concat1--------------")
/**
 옵저버들을 하나로 엮는, Java String의 concat 메소드와 비슷한 메커니즘
 */
let 노랑반어린이들 = Observable<String>.of("응애1","응애2","응애3")
let 선생님 = Observable<String>.of("쌤")

Observable.concat([선생님,노랑반어린이들])
    .subscribe(onNext: {
        print($0)
    })

print("-------------concat2--------------")


