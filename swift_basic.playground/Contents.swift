import UIKit

//배열 선언방법
var values : Array<Int> = Array<Int>()
values.append(1)
values.append(2)

var names1 = [String]()
var names2 : [String] = []

// 딕셔너리 선언방법
var dic1 : Dictionary<String, Int> = Dictionary<String,Int>()
var dic2 : [String:Int] = ["key":1]
dic2["김철수"] = 3
dic2.removeValue(forKey: "key")
dic2

// set
// set생성에는 축약형이 없음.
var set : Set = Set<Int>()
set.insert(10)
set.insert(20)
set.insert(30)
set.insert(30)
set
set.remove(10)
set

//-----------------함수 선언방법-----------------
func sum(a: Int,  b : Int) -> Int{
    return a+b
}
sum(a:5, b:3)

func hello()->String{
    return "Hello"
}

hello()

func printName()->Void{
    
}

func greeting(freind:String, me:String = "gunter"){
    print("Hello, \(freind)! I'm \(me)")
}

greeting(freind : "SeongJun")

//전달 인자 레이블
/*func 함수이름(전달인자 레이블 매개변수 이름: 매개변수 타입) -> 반환타임 */

func sendMessage(from1 myName:String, to1 name: String)->String{
    return "Hello \(name)! I'm \(myName)"
}

sendMessage(from1:"Gunter",to1:"SejongJun")

//전달 인자 매개변수 금지
func sendMessage(_ name:String) -> String{
    return "Hello \(name)"
}
//매개변수 이름없이 값 전달 가능해짐.
sendMessage("SeongJun")

//가변 매개변수 사용
func sendMessage(me:String, friends:String...)->String{
    return "Hello \(friends)! I'm \(me)"
}
sendMessage(me:"SeongJun", friends: "Json","Albert","Gunter")

//-----------------조건문-----------------
// if, switch, guard존재

let age = 20
if age<19{
    print("미성년자")
}
//if, else문
if age<19{
    print("미성년자 입니다.")
}else{
    print("성년자 입니다.")
}

//if, else if, else문
let animal = "cat"
if animal=="dog"{
    print("강아지 사료주기")
}else if animal == "cat"{
    print("고양이 사료 주기")
}else{
    print("해당하는 동물 사료가 없음")
}
//switch문
/*
 switch 비교대상{
 case 패턴1:
 //패턴1이 일치할 때 실행되는 구문
 case 패턴2, 3:
 // 패턴2, 3이 일치할 때 실행되는 구문
 default:
 // 어느 비교 패턴과도 일치하지 않을 때 실행되는 구문
 }
 */

//switch문 예제1
let color = "red"
switch color{
case "blue":
    print("파란색 입니다.")
case "green","red":
    print("초록색 혹은 빨간색 입니다.")
default:
    print("찾는 대상이 없습니다.")
}
//switch문 예제2_범위 조건문
let temperature = 30
switch temperature{
case -20...9:
    print("겨울입니다.")
case 10...14:
    print("가을입니다.")
case 15...25:
    print("봄 입니다.")
case 26...35:
    print("여름입니다.")
default:
    print("이상기후 입니다.")
}


//반복문 예제
/*
 for 루프상수 in 순회대상{
 실행할 구문
 }
 */

for i in 1...4{
    print(i)
}

let array = [1,2,3,4,5]
for i in array{
    print(i)
}

var number = 5
while number < 10{
    number+=1
}
number

/*
 조건에 상관없이 한 번은 무조건 실행(Java Do-while문이랑 같음)
 repeat{
 실행구문
 }while 조건식
 */

var x = 6
repeat{
    x+=2
}while x<5
print(x) // 적어도 한 번은 실행됨.

//옵셔널 -< swift특징중 하나
//옵셔널의 의미는 값이 있을 수있고 없을 수 있다.
//java에선 값이 없는 경우 null, swift에선 nil을 사용한다.
//java에선 변수 선언시 값을 안 넣어줘도 됐는데, Swift에선 옵셔널 이란 것을 사용해야 한다.
//변수에 nil을 지정할 경우 타입뒤에 ?를 붙여 옵셔널이란 것 을 알려준다.
/*var number:Int ? = nil*/
var name: String?
var optionalName: String? = "Gunter" //옵셔널에도 값을 초기화 할 수 있다.
print(optionalName) //옵셔널로 wrapped되어 있는 것은 일반 변수와 연산이 불가능. -< optional binding이란 것을 해줘야 사용 가능.
// var requiredName: String = optionalName // -> unwrapp에러 발생

//옵셔널 해제 방법은 다음과 같다.
/*
 명시적 해제
 1. 강제 해제
 2. 비강제 해제(옵셔널 바인딩*/
/*
 묵시적 해제
 1. 컴파일러에 의한 자동 해제
 2. 옵셔널의 묵시적 해제
 */

//명시적 해제 1. 강제 해제
var number1 : Int? = 3
print(number1)
print(number1!) //->강제 해제 -> 위험한 방법 -> nil을 unwrapp하게돼 프로그램이 종료됨

//강제 해제의 안전한 방법1(상수를 사용한 방법)
if let result = number1 {
    print(result)
}else{
    
}
//강제 해제의 안전한 방법2(guard문)
func test(){
    let number: Int? = 5
    guard let result = number else{return} //guard문은 조건이 충족 될 때만 다음 구문으로 넘어가고 아니면 else구문을 탄다.
    print(result)
}

test()

//if문으로 optional을 추출하면 if 불록 내에서만 추출값을 사용 가능하지만, guard문을 사용하게 되면 같은 함수내에서 optional추출값 사용 가능.

//묵시적 해제 1.컴파일러에 의한 자동 해제
let value : Int? = 6
if value == 6{ //묵시적 자동 해제 -> 옵셔널은 비교 연산자와 연산할시 자동으로 값 추출후 비교한다.
    print("value가 6입니다.")
}else{
    print("value가 6이 아닙니다.")
}
//묵시적 해제 2. 옵셔널의 묵시적 해제
//값을 사용할때는 자동으로 optional이 해제됨
let string = "12"
var StringToInt: Int! = Int(string)
print(StringToInt+1)

//swift는 구조체와 클래스를 가지고 있다.
//구조체의 인스턴스는 값, 클래스의 인스터느스는 참조 -> 이후에 강의한단다.

/* 구조체 형식
 struct 구조체 이름{
 프로퍼티와 메서드
 }
*/

//구조체의 이름은 Pascal표기법(대문자 시작)이 관행
struct User {
    var nickname: String
    var age: Int
    func information(){
        print("\(nickname) \(age)")
    }
}

//자동생성자가 만들어짐
var user = User(nickname: "Gunter", age: 30)
user.nickname
user.age
user.nickname = "ablert"
user.nickname
user.information()
/* 클래스 형식
 class 클래스 이름{
 프로퍼티 메소드
 }
 */
class dog{
    var name : String = ""
    var age : Int = 0
    
    init(){ // 생성자 -> java와 달리 init키워드를 사용한다.
        
    }
    func introduce(){
        print("name \(name) age\(age)")
    }
}

var test1 = dog()
test1.age = 3
test1.name = "CoCo"
test1.introduce()

//초기화란 -> 클래스 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정
//인스턴스가 생성되면 구조체나 클래스내 init키워드(생성자)가 실행된다.
//인스턴스가 생성될 때 필요한 설정을 하기 위해 사용된다.

/*
 init(매개변수 : 타입, ...){
 //프로퍼티 초기화
 //인스턴스 생성시 필요한 설정을 해주는 코드 작성
 }
 */

class User2{
    var nickname:String
    var age:Int
    
    init(nickname:String, age:Int){
        self.nickname = nickname
        self.age = age
    }
    
    deinit{
        print("deint user")
    }
}

var user2 = User2(nickname: "SeongJun", age: 28)
user2.nickname
user2.age

/*  deinitialize
 1. deinitialize는 인스턴스가 메모리에 해제되기 직전에 실행
 2. 클래스에서만 사용이 가능하다.
 */

var user3: User2? = User2(nickname: "Gunter", age: 23)
user3 = nil // nil값을 참조하면 -> 자동으로 메모리 해제

/*
 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻한다.
 종류는 다음과 같다
 1. 저장 프로퍼티 -> 인스턴스의 변수, 상수
 2. 연산 프로퍼티 -> 특정연산의 결과값
 3. 타입 프로퍼티 -> 특정 타입에서 사용
*/

//1.저장 프로퍼티
struct Dog1{
    //저장 프로퍼티
    var name : String
    let gender : String
}

var dog1 = Dog1(name: "Gunter", gender: "Male")
print(dog1)
dog1.name = "김성준"

let dog2 = Dog1(name:"Gunter", gender:"Male")
//dog2.name("SeongJun") // -> 에러가난 이유는 구조체의 인스턴스 dog2가 상수이기 때문에 변수 프로퍼티여도 값 변경 불가 -> 이러한 결과는 구조체가 value(값)type이기 때문에 상수로 인스턴스가 선언되면 내부 프로퍼티도 상수가돼서 수정이 불가. 클래스의 경우 참조이기 때문에 상수로 인스턴스가 선언되도 내부 변수프로퍼티는 수정 가능

class Cat3{
    var name : String
    let gender : String
    
    init(name:String, gender:String){
        self.name = name
        self.gender = gender
    }
}

let cat3 = Cat3(name: "Json", gender: "Male")
cat3.name = "Gunter"
//cat3.gender = "Fmale"
print(cat3.name)
//print(cat3.gender) -> 참조 type이라 해도 해당 클래스내 저장 프로퍼티가 타입이 상수이면 값 변경 불가능하다. -> 참조 타입(class)과 값 타입(struct)은 밑에 설명이 있다.

/* 2.연산(계산) 프로퍼티
 1) 저장 프로퍼티는 구조체, 클래스에서만 사용 가능한 반면, 연산 프로퍼티는 추가적으로 열거체에서도 사용이 가능하다.
 2) 값을 직접적으로 저장하지 않는 대신, geeter, setter를 통해 다른 프로퍼티와 값을 접근가능
 */
struct Stock{
    var averagePrice : Int
    var quantity : Int
    //(연산형)계산형 프로퍼티
    var purcharsePrice : Int{
        get{
            return averagePrice*quantity
        }
        //새로운 값이 설정되면 set 매개변수로 전달됨.
//        set(newPrice){
//            averagePrice = newPrice / quantity
//        }
        //set 사용방법2
        //매개변수 없이 newValue로도 매개변수 전달이 가능
        set{
            averagePrice = newValue / quantity
        }
    }
}

var stock = Stock(averagePrice: 2300, quantity: 3)
print(stock)
stock.purcharsePrice
stock.purcharsePrice = 3000
stock.averagePrice

/* 프로퍼티 옵저버
 1. 프로퍼티 값의 변화를 관찰하고 반영
 2. 새로운 값이 기존값이 같더라도 호출
 3. 프로퍼티가 set 될때마다 호출
 4. 저장 프로퍼티와, overriding된 저장, 연산 프로퍼티에서만 사용이 가능하다.
 */

class Account{
    var credit : Int = 0{
        //프로퍼티 옵저버 종류는 두 가지이다.
        willSet{ //1. 값이 저장되기 전에 호출되는 willSet옵저버
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet{ //2. 값이 저장된 후에 호출되는 didSet옵저버
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
}

var account = Account()
account.credit = 1000

/* 타입 프로퍼티
 인스턴스 생성 없이 객채내 프로퍼티 접근을 가능하기함
 프로퍼티 자체와 연결한다는 개념
 스태틱 키워드를 사용하여 정의
 */

struct SomeStructrue{
    static var storedTypeProperty = "Some value." //스토어
    static var computedTypeProperty : Int{ //컴퓨티드
        return 1
    }
}

SomeStructrue.computedTypeProperty
SomeStructrue.storedTypeProperty
SomeStructrue.storedTypeProperty = "hello"
SomeStructrue.storedTypeProperty

/* 클래스와 구조체의 차이점
 --------------공통점--------------------
 1. 값을 저장할 프로퍼티 선언할 수 있다.
 2. 함수적 기능을 하는 메서드를 선언 할 수있다.
 3. 내부 값에 .을 사용하여 접근할 수 있다.
 4. 생성자를 사용해 초기 상태를 설정할 수 있다.
 5. extension을 사용하여 기능을 확장할 수 있습니다.
 6. protocol을 채택하여 기능을 설정할 수 있습니다.
 
 ---------------차이점--------------------
 클래스
 1. 참조 타입
 2. ARC로 메모리를 관리
 3. 상속이 가능
 4. 타입 캐스팅을 통해 런타임에서 클래스 인스턴스의 타입을 확인할 수 있음
 5. deinit을 사용하여 클래스 인스턴스의 메모리 할당을 해제전 컨트롤 할 수 있다.
 6. 같은 클래스 인스턴스를 여러 개의 변수에 할당한 뒤 값을 변경 시키면 모든 변수에 영향을 준다.(메모리가 복사 됨)
 구조체
 1. 값 타입.
 2. 구조체 변수를 새로운 변수에 할당할 때마다 새로운 구조체가 할당.
 3. 즉 같은 구조체를 여러 개의 변수에 할당한 뒤 값을 변경시키더라도 다른 변수에 영향을 주지 않는다.(값 자체를 복사)
 */

class someClass{
    var count: Int = 0
}

struct SomeStruct{
    var count : Int = 0
}

//6번 메모리 복사
var class1 = someClass()
var class2  = class1
var class3 = class1

class3.count = 3
class1.count

var struct1 = SomeStruct()
var struct2 = struct1
var struct3 = struct1

struct2.count = 3
struct3.count = 4

struct1.count
struct2.count

/* 상속
 상속은 클래스에서 가능하다
 java와 동일하지만, 상속받은 저장, 연산 프로퍼티, 메소드가 변경되면 감시하는 역활을 가지는 것도 있음
 */
/* 상속 문법
 class 클래스 이름: 부모클래스 이름{
 //하위 클래스 정의
 }
 */
class Vehicle{
    //final키워드를 사용하면 재정의를 불가능하게 한다. 마찬가지로 클래스 앞에 final이면 상속을 불가능하게 한다.
    var cureentSpeed = 0.0
    //연산 프로퍼티
    var description : String{
        return "traveling at \(cureentSpeed) miles per hour"
    }
    //메소드
    func makeNoise(){
      print("speaker on")
    }
}

class Bicycle: Vehicle{
    var hasBasket = false
}

var bicycle = Bicycle()
bicycle.cureentSpeed
bicycle.cureentSpeed = 1.0
bicycle.cureentSpeed

//override는 override키워드를 사용해야한다.
class Train:Vehicle{
    override func makeNoise() {
        super.makeNoise()
        print("choo choo")
    }
}

var trian = Train()
trian.makeNoise()

//property override 사용법
/*
 property override는 부모 프로퍼티들(type, instance(저장) 프로퍼티를 재정의 가능하다.)
 재정의 한다는 것은 프로퍼티 자체가 아니라, get, settter, observer들을 재정의 한다는 것이다.
 자식과 부모 프로퍼티의 이름과 타입이 같아야한다.
 */

class Car3: Vehicle{
    var gear = 1
    override var description: String{
        return super.description + " in gear \(gear)"
    }
}

let car = Car3()
car.cureentSpeed = 30.0
car.gear = 2
print(car.description)

class AutomaticCar : Car3{
    override var cureentSpeed: Double{
        didSet{
            gear = Int(cureentSpeed/10)+1
        }
    }
}

let automatic = AutomaticCar()
automatic.cureentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

/* 타입 캐스팅
 인스턴스의 타입을 확인하거나
 어떤 클래스의 인스턴스를 해당 클래스 계층 구조의 슈퍼 클래스 혹은 서브 클래스로 캐스팅하는 방법이다.
 is, as연산자로 캐스팅한다.
 */

class MediaItem{
    var name : String
    init(name :String){
        self.name = name
    }
}

class Movie: MediaItem{
    var director: String
    init(name: String, director:String){
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem{
    var artist : String
    init(name:String, artist:String){
        self.artist = artist
        super.init(name: name)
    }
}

let library = [ // library는 배열의 서브 클래스들을 타입추론해 상위 클래스인 MediaItem를 추론하다.
    Movie(name:"기생충",director: "봉준호"),
    Song(name: "butter", artist: "BTS"),
    Movie(name: "올드보이", director: "박찬욱"),
    Song(name: "wonderwall", artist: "Oasis"),
    Song(name: "Rain", artist: "이적")
]
var movieCount = 0
var songCount = 0

for item in library{
    if item is Movie{
        movieCount += 1
    }else if item is Song{
        songCount += 1}
}

movieCount
songCount

for item in library{
    //다운캐스팅 사용법 -> as?, as! -> !표 사용시 강제 unwrapping이기 때문에 null(형변환 실패)시 runtime error발생 확률이 있다.
    //첫 번째 조건문을 해석하면 다음과 같다. item배열 요소가 Moive로 다운캐스팅 할 수 있으면 movie변수에 지정한다.
    if let movie = item as? Movie{
        print("Moive: \(movie.name), dir . \(movie.director)")
    }else if let song = item as? Song{
        print("Song: \(song.name), by \(song.artist)")
    }
}

/*
 assert와 guard 함수
 1. assert
    특정 조건을 체크하고, 조건이 성립되지 않으면 런타임 에러 발생, 그리고 설정 메세지를 출력 하게 할 수 있는 함수.
    assert함수는 디버깅 모드에서만 동작하고 주로 디버깅 중 조건의 검증을 위하여 사용합니다.
 2. guard
    뭔가를 검사해 그 다음에 오는 코드를 실행할지 말지 결정하는 함수
    guard문에 주어진 조건문이 거짓일 때 구문이 실행됨
*/

var value1 = 0
assert(value1 == 0)

value1 = 2
//assert(value1 == 0,"값이 0이 아닙니다.")
//즉, assert는 디벙깅 중 조건의 검증을 위해 사용


//guard문은 함수의 값으로 잘 못 된것을 필터링 하기 위해 사용
/*
 guard 조건 else{
 //조건이 false 이면 else 구문이 실행되고
 return or throw or break 를 통해 이 후 코드를 실행하지 않도록 한다.
 }
 */
func guardTest1(value : Int){
    guard value == 0 else { return }
    print("안녕하세요")
}

guardTest1(value:0)

//guard문을 활용해 optional unwrap하기
func guardTest2(value : Int?){
    guard let value = value else { return print("nil입니다.")} //guard var의 경우 변수를 변하지 않는 값(name=name)을 주었기 때문에 compiler가 상수로 바꿀것을 권유함. ->띠라서 그냥 let을 사용하자.
    print(value)
}

guardTest2(value: 2)
guardTest2(value: nil)

/*
 특정 역활을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진 -> java 인터페이스와 비슷하지만, 요구사항을 지정할 수 있다.
 **형식**
 protocol 이름{
    
 }
 */
protocol SomeProtocol{
    
}

protocol SomeProtocol2{
    
}
struct SomeStructure : SomeProtocol, SomeProtocol2 {
    
}
/* 복붙
 class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol
 */

protocol FristProtocol{
    var name: Int{get set} // read, write
    var age: Int{get} // readonly
}

protocol AnotherProtocol{
    static var someTypeProperty: Int {get set} // read
}

protocol FullyNames{
    var fullName:String{get set} // read
    func printFullName(someName:String)
//    func printFullName2(someName:String="Test")  // protocol 메소드의 매개변수는 default값을 지정할 수 없다.
}

struct Person: FullyNames{
    var fullName: String
    func printFullName(someName:String) {
        print(fullName)
    }
}

protocol SomeProtocol3{
    func someTypeMethod()
}

protocol someProtocol4{
    init(someParameter:Int)
}

protocol Someprotocol5{
    init()
}

class SomeClass:Someprotocol5{
    //생성자의 경우 required키워드를 사용, 구조체는 필요없음.
    required init(){}
}

final class SomeFinalClass:Someprotocol5{
    //final 클래스의 경우 required키워드를 사용하지 않아도 됨.
    init(){
        
    }
}

/*
 익스텐션
 기존의 클래스, 구조체, 열거형, 프로토콜에 새로운 기능을 추가하는 기능
 연산 타입 프로퍼티/연산 인스턴스 프로퍼티
 타입 메서드/인스턴스 메서드
 이니셜라이저
 서브스크립트
 중첩 타입
 특정 프로토콜을 준수할 수 있도록 기능 추가
 단, 오버라이드는 불가
 
 extension SomeType{
 //추가기능
 }
 */

extension Int {
    var isEven:Bool{
        return self % 2 == 0
    }
    
    var isOdd: Bool{
        return self%2 == 1
    }
}

var number5 = 3
number5.isOdd
number5.isEven

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
}

var stringConvertToInt = "0"
stringConvertToInt.convertToInt()

/*
 열거형
 연관성이 있는 값을 모아 놓은 것을 말한다. ex(봄, 여름, 가을, 겨울같이)
 */
enum CompassPoint{
    case north
    case south
    case east
    case west
}

var direction = CompassPoint.east
direction = .south // 컴파일러에 의해 자동으로 타입이 CompassPoint란걸 추론함.
direction

switch direction{
case .north:
    print("North")
case .south:
    print("south")
case.east:
    print("east")
case.west:
    print("west")
}
//enum에 특정값(원시값)을 가지게 할 수 있다.
enum CompassPointNature: String{
case north = "북"
case south = "남"
case east = "동"
case west = "서"
}
var compasspointnature = CompassPointNature.north
compasspointnature.rawValue //rawValue키워드를 사용해 원시값을 가져올 수 있다.

//원시값을 통해 열거형 항목을 받환할 수 있다.
let direction2 = CompassPointNature(rawValue:"남")
direction2

//열거형은 연관값을 가질수 있다.
//열거형 항복 옆에 소괄호로 연관값을 가지게 할 수 있다.
enum PhoneError {
    case unknown
    case batteryLow(String)
}

let error = PhoneError.batteryLow("배터리가 곧 방전됩니다.") // (배터리가 곧 방전됩니다.)이 연관값임.
print(error) // 연관값을 추출하려면 switch, if문을 돌려야 한다.
switch error{
case.batteryLow(let message): //연관값을 넘겨 받을수 있게 매개변수로 let 상수를 사용.
    print(message)
case.unknown:
    print("알 수 없는 에러입니다.")
}

/*
 옵셔널 체이닝
 옵셔널에 속해 있는 nil 일지도 모르는 프로퍼티, 메소드, 스브스크립션등을 가져오거나 호출할 때 사용할 수 있는 **일련의 과정**
 */

struct Developer{
    let name : String
}
struct Company{
    let name : String
    var developer :  Developer?
}

var developer = Developer(name: "han")
var compnay = Company(name:"Gunter",developer: developer)
print(compnay.developer)
//print(compnay.developer.name) // optional로 감싸져 있어 optional을 unwrapped해야 한다. -> 이때 optional changing을 사용한다.
//optional chaninng하는 다음과 같다
print(compnay.developer?.name) //?로 optional channing을 하면 Optional로 감싸 있는 값을 얻을 수 있다.
print(compnay.developer!.name)// !로 optional channing을 하면 강제로 unwrapping된 값을 얻을 수 있다.

//try catch문
//swift에선 런타임에 발생한 에러를 다음과 같은 프로세스로 처리한다.
//발생(thrwoing) -> 감지(catching) -> 전파(propagating) -> 조작(manipulating)
//에러 프로토콜을 채택해서 사용한다.
enum PhoneError1:Error{ //Error<- 에러 프로토콜
    case unknown
    case batteryLow(batteryLevel : Int)
}

//throw PhoneError1.batteryLow(  batteryLevel: 20)

/*
 swift에서 오류를 처리하는 방법 4가지
 1. 함수내에서 해당 함수를 호출한 곳에서 처리하는 방법 (전파)
 2. do catch문을 사용
 3. optional값으로 오류 처리
 4. 오류가 발생하지 않을거라는 확신 -->????
 */

func checkPhoneBatteryStatus(batteryLevel:Int) throws -> String{ //해당 함수를 호출한 곳으로 전파
    guard batteryLevel != -1 else {throw PhoneError1.unknown} // -> -1이면 guard의 else를 탄다.
    guard batteryLevel > 20 else {throw PhoneError1.batteryLow(batteryLevel:batteryLevel)}
    return "배터리 상태가 정상입니다."
}

//do-catch문 사용
/*
 do{
    try 오류 발생 가능코드
 } catch 오류 패턴{
 처리 코드
 }
 */

do{
    try checkPhoneBatteryStatus(batteryLevel: 19)
}catch PhoneError1.unknown{
    print("알수 없는 에러입니다.")
}catch PhoneError1.batteryLow(let baterryLevel){
    print("배터리 전원 부족 남은 배터리: \(baterryLevel)%")
}catch{
    //블록이 없어도 실행됨 /error라는 지역상수가 생김
    print("그 외 오류 발생 : \(error)")
}

//try ?를 사용한 오류처리
/*
 1. optional로 처리할 수 있음.
 2. try? 키워드를 사용
 */

let status = try? checkPhoneBatteryStatus(batteryLevel: -1)
print(status) // error가 발생하게되면 nil값이 반환됨.
let status1 = try? checkPhoneBatteryStatus(batteryLevel: 21) //만약 에러를 던져주지 않으면 optional객체를 반환.
print(status1) //?는 optional로 바인딩됨
let status2 = try! checkPhoneBatteryStatus(batteryLevel: 21) //에러가 발생되지 않을때 사용, 만약 Exception이 발생하게되면 강제종료됨.
print(status2)

//클로저
/*
 참조타입이다.
 1. 코드에서 전달 및 사용할 수 있는 독립 기능 블록
 2. 일급 객체의 역활을 할 수 있음
    ->일급 객체란?
    ->전달 인자로 보낼수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수 있다.
 3. 보통 클로저라 하면,  익명함수를 지칭한다.(unNamed closure)하지만, 익명함수(Named Clousre)가 없는 게 아니다.
 4. 표현식
 {
 //(매개 변수) -> 리턴 타입 in
 //실행구문
 }
 */

let hello1 = { ()->() in
    print("hello")
    
}

//클로저 호출
hello1()

var hello2 = {
    (name:String) -> String in
    return "Hello, \(name)"
}

//hello2(name:"Gunter")  -> 클로저에서 전달인자 레이블을 적으면 에러가 발생
print(hello2("Gunter"))

//클로저를 함수의 파라미터로 전달하기
func doSomeThing3(closure: () -> ()){
    closure() //아래 코드에서 함수호출시 closure 바디내 print구문 실행
}

doSomeThing3(closure: {() -> ()
    in print("hello")
})

//클로저의 가독성이 안 좋으면 후행클로저 기능을 사용하기도 한다
doSomeThing3 (){ // 클로저의 매개변수, 반환타입이 없으니 매개변수 생략, 반환타입 생략 가능
    print("hello2")
}

doSomeThing3

doSomeThing3 { //하나의 매개변수로 전달하는 경우에는 ()를 생략해도 됨
    print("hello3")
}
//

//함수에서 반환 타입으로  closure사용하기
func doSomeThing4() -> () -> (){
    return{ () -> () in
        print("hello4")
    }
}
doSomeThing4()
doSomeThing4()()

//다중 후행 클로저 문법
func doSomething2(sucess: () -> (), fail: () -> ()){//sucess와 fail이라는 두 개의 클로저가 선언
    
}

doSomething2 {
    //첫 번째 클로저는 매개변수 레이블 생략
} fail: {
    <#code#>
}

//문법을 최소화해 다중 후행 클로저 선언하기
func doSomething5(closure: (Int,Int,Int) -> Int){
    closure(1,2,3)
}

doSomething5(closure: {(a,b,c) in
    return a+b+c
    
})

doSomething5(closure: {
    return $0+$1+$2
})

doSomething5(){
    $0+$1+$2
}

doSomething5{ //하나의 매개변수만 전달할 때는 소괄호도 생략 가능
    $0+$1+$2
}

/*
 고차함수
 다른 함수를 전달 인자로 받거나 함수 실행의 결과를 함수로 반환하는 함수
 map, filter, reduce 3가지 종류가 있음. -> collection type에 존재
 */

//map
let numbers = [0,1,2,3]
let mapArray = numbers.map{ (number) -> Int in //map은 기존 컨테이너에서 새로운 값을 변경해 또 다른 새로운 컨테이너를 만든다.
    return number * 2
}
print("map \(mapArray)")

//filter -> 컨터이너 내부에 값을 걸러서 새로운 컨테이너로 추출
let intArray = [10,5,20,13,4]
let filterArray = intArray.filter{$0 > 5} //closer 간소화 표현으로 작성됨
print("filter \(filterArray)")

//reduce
let someArray = [1,2,3,4,5]
let reduceResult = someArray.reduce(0){ //초기값 숫자0부터 누적시작
(result:Int, element:Int)->Int in
    print("\(result) + \(element)") //result는 누적값, element는 배열의 인덱스
    return result + element
}

print("reduce \(reduceResult)")
