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

//하나의 옵저버를 생성해 묶는방법
Observable.concat([선생님,노랑반어린이들])
    .subscribe(onNext: {
        print($0)
    })

//옵저버블로 다른 옵저버와 묶는방법
print("-------------concat2--------------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//flatMap과 비슷하지만 다름, conCat은 합쳐지는데 순서를 고려하고, 서로다른 옵저버들이 한개씩 처리됨, 즉 한 옵저버가 다른 옵저버의 작업처리를 기다려 FlatMap보다 성능이 떨어질 수 있음(여러 데이터 처리일때)
print("-------------concatMap-------------")
let 어린이집: [String:Observable<String>] = [
    "노랑반" : Observable.of("응애1","응애2","응애3"),
    "파랑반" : Observable.of("애기1","애기2")
]

Observable.of("노랑반","파랑반")
    .concatMap{ 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//Merge, Concat, FlatMap들은 옵저버들을 합치지만, 용도 및 동작방식이 틀림
//FlatMap 옵저버의 요소를 1차원 배열로 펼치기 위함
print("-------------Merge1-------------")
let 강북 = Observable.from(["강북구","서대문구","동대문구","종로"])
let 강남 = Observable.from(["강남구","강동구","영등포구","양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------Merge2-------------")
Observable.of(강북,강남)
    .merge(maxConcurrent: 1) //이벤트를 받을 옵저버들(강북,강남)을 처리할 수 즉, 1이란 먼저받은 옵저버의 처리가 끝날때 까지 다른 옵저버를 처리하지 않는다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------CombineLatest1-------------")

let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable.combineLatest(성,이름){ 성, 이름 in
    성+이름
}
    
성명
    .subscribe(onNext: {
    print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

print("-------------CombineLatest2-------------")
let 날짜형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 날짜 = Observable<Date>.of(Date())

Observable.combineLatest(
    날짜형식,
    날짜,
    resultSelector: { 형식, 날짜 -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = 형식
        return dateFormatter.string(from: 날짜)
    }
)
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

print("-------------CombineLatest3-------------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable.combineLatest([lastName, firstName]){ name in
    name.joined(separator: " ")
}

fullName.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

lastName.onNext("김")
firstName.onNext("성준")
firstName.onNext("스텔라")
firstName.onNext("초이")

print("-------------zip-------------")
//merge와 다른점은, 옵저버는 합칠 이벤트 요소들의 갯수가 매칭과 상관없이 합쳤다면, zip은 이벤트 갯수에따라 합쳐진다
enum 승패 {
    case 승
    case 패
}

//let 승부 = Observable<승패>.of(.승, .승, .패, .승, .승)
let 승부 = Observable<승패>.of(.승, .승, .패)
let 선수 = Observable.of("🇰🇷","🇨🇭","🇺🇸","🇹🇭","🇮🇩")

let 시합결과 = Observable.zip(승부, 선수) { 결과, 대표선수 in
    return 대표선수 + "선수" + "\(결과)"
}

시합결과.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

print("-------------withLatestForm1-------------")
//특정 트리거(ex) onNext)가 발생하면 조합시키는 Operator
let 🚀 = PublishSubject<String>()
let 달리기선수 = PublishSubject<String>()

🚀.withLatestFrom(달리기선수) // 🚀옵저버블이 발생했을때, 달리기선수 옵저버블 이벤트가 발생됨
                            // 달리기선수의 최신 이벤트가 발생됨.
//    .distinctUntilChanged() //동일한 이벤트는 걸러줘서 withLatestFrom는 sample operator과 동일하게 작동됨
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

달리기선수.onNext("🏃‍♀️")
달리기선수.onNext("🏃‍♀️ 🏃🏼‍♂️")
달리기선수.onNext("123")

🚀.onNext("시작")
🚀.onNext("시작")

print("-------------sample-------------")
//withLatestFrom과 비슷 하지만, 한 번만 발생하는 Operator 트리거이다.
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


F1선수.onNext("빨간차")
F1선수.onNext("빨간차 뒤에 노란차")
F1선수.onNext("빨간차 뒤에 노란차 뒤에 흰색차")

출발.onNext(Void())
출발.onNext(Void())
출발.onNext(Void())

print("-------------amb-------------")
//다수의 옵저버가 있으면 그 중 먼저 발생한 옵저버만 구독함.
let 버스1 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()

let 버스정류장 = 버스1.amb(버스2)

버스정류장.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

버스1.onNext("버스1-승객1")
버스2.onNext("버스2-승객0")
버스2.onNext("버스2-승객1")
버스2.onNext("버스2-승객2")
버스1.onNext("버스1-승객2")
버스1.onNext("버스1-승객3")

print("-------------switchLatest-------------")
//소스에 들어온 옵저버의 이벤트만 방출
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>() //소스


let 손든사람만말할수있음 = 손들기.switchLatest()

손든사람만말할수있음.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("학생1: 시작")
학생2.onNext("학생2: 시작")

손들기.onNext(학생2)
학생1.onNext("학생1: 누가 말할수 있지")
학생2.onNext("학생2: 누가 말할수 있지")

손들기.onNext(학생3)
학생3.onNext("학생3: 나도 말할수 있어?")
학생1.onNext("학생1: 나 아닐까")
학생2.onNext("학생2: 에이 나지")

print("-------------reduce-------------")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//       return summary + newValue
//    })
//    .reduce(0) {
//        summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------scan-------------")
//reduce와 동일한 역활을 하지만, reduce는 어떤 요소의 결과만 보여준다면, scan은 과정들까지 보여줌.
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

