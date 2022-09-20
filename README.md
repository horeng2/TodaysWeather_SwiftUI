# 오늘의 날씨 프로젝트
- OpenWeather API를 이용한 날씨 정보 앱 개발 프로젝트입니다.
- [기존 UIKit 프로젝트](https://github.com/horeng2/TodaysWeather)를 `Combine`/`SwiftUI`로 리팩토링하였습니다.

## 목차
- [키워드](##키워드)
- [프로젝트 소개](#프로젝트-소개)
- [디렉토리 구조](#디렉토리-구조)
- [기능](#기능)
- [시도해본 점](#시도해본-점)
- [Trouble Shooting](#trouble-shooting)

## 키워드
- `Combine`
- `SwiftUI`
    - `Animation`
    - `ProgressView`
    - `NavigationView`
- `Dependency Injection Container`
- `Localization`
    - `String localization`
    - `Image localization`
- `OpenWeather API`

## 프로젝트 소개
OpenWeather API를 이용한 날씨 정보 앱입니다.

Combine을 이용해 통신하며, 최초 로딩화면에 Animation이 적용되었습니다.

## 디렉토리 구조
```
├── Presenter
│   ├── Views
│   │   ├── LodingView
│   │   ├── CityListView
│   │   ├── CityRowView
│   │   └── WeatherDetailView
│   └── ViewModel
│       └── CityListViewModel
├── Domain
│   ├── Model
│   │   ├── City
│   │   └── CityWeather
│   └── UseCase
│       └── WeatherUseCase
└── Data
│   ├── Repository
│   │   └── WeatherRepository
│   └── Entity
│       ├── ResponseWeatherData
│       └── WeatherCondition
├── APICall
│   ├── APICaller
│   │   └── APIProvider
│   ├── Request
│   │   └── WeatherInfoRequest
│   └── Interface
│       └── APIRequest
├── Localization
│   ├── Localization
│   └── String+Extension
├── Uillity
│   ├── DIContainer
│   ├── Parsing
│   ├── WeatherError
│   └── Double+Extension
└── Resources
    ├── APIKeyBundle
    ├── SecretKey.plist
    ├── Info.plist
    └── Assets.xcassets

```
---

## 기능
- 한국어

|초기 화면|동작 화면|
| :-: | :-: |
|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 45 20](https://user-images.githubusercontent.com/87305744/190971560-24064149-badd-4efc-8756-744052d8e065.gif)|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 01 14](https://user-images.githubusercontent.com/87305744/190969998-9b4e1c20-f444-4c0a-849c-3fd683e44675.gif)|

- 영어

|초기 화면|동작 화면|
| :-: | :-: |
|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 02 15](https://user-images.githubusercontent.com/87305744/190969964-d78b2452-2010-4ee2-b736-02a26ed6f171.gif)|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 04 12](https://user-images.githubusercontent.com/87305744/190970118-aa1467ac-4721-4766-a93f-80e2ed39f42b.gif)|

<br/>
<br/>

## 시도해본 점
### Combine을 이용한 통신
- UIKit을 이용한 프로젝트에서 @escaping, complitionHandler를 이용하여 통신했던 부분을 Combine을 통해 구현했습니다.
```swift
func request<T: APIRequest>(requestType: T) -> AnyPublisher<T.ResponseType, WeatherError> {
    guard let request = requestType.urlRequest else {
        return Fail(error: WeatherError.createUrlError).eraseToAnyPublisher()
    }

    return self.session
        .dataTaskPublisher(for: request)
        .mapError{ error in
                .responseError
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
}
```
### Loding View 구현
- 데이터가 비어있거나, isLoding 객체가 true일 경우 Loding View가 노출되도록 구현하였습니다.
- `async`/`await`, `Task.sleep`을 이용해 로딩화면의 노출 시간을 설정했습니다.
```swift
private func loadingViewTask() async {
    try? await Task.sleep(nanoseconds: 2_500_000_000)
    self.isLoading = false
}
```
- 지정된 시간이 지났음에도 데이터가 비었있을 경우를 대비하여 로딩화면의 노출 조건에 데이터의 상태도 함께 추가했습니다.
```swift
if isLoading || dataSource.isEmpty {
            LoadingView(isLoading: $isLoading)
        } else {
            content
        }
```

### Animation
- `@State` 객체로 이미지의 위치값을 갖게 하여 offset이 지속적으로 변동되도록 구현했습니다.
- Image View의 `.onApear`를 통해 애니메이션을 지정해주었습니다.
```swift
Image("sun")
    .resizable()
    .frame(width: iconWidth, height: iconHeight)
    .frame(maxHeight: .ulpOfOne)
    .offset(x: imageLocation)
    .transition(.move(edge: .trailing))
    .onAppear{
        let baseAnimation = Animation.easeOut.speed(0.2)
        let repeated = baseAnimation.repeatForever(autoreverses: false)
        withAnimation(repeated) {
            imageLocation += UIScreen.main.bounds.width + iconWidth
        }
    }
```

### DIContainer
- Repository, UseCase, ViewModel을 생성할 때 의존성 주입을 위해서 DIContainer를 사용했습니다.
- register를 통해서 사용할 인스턴스를 등록해두고, resolve를 통해서 객체를 이용합니다.

<br/>
<br/>

## Trouble Shooting
### 뷰의 구성요소가 늘어남에 따라 코드의 가독성이 떨어지는 점
- 문제
body에서 뷰의 구성요소들을 구현하면서 클로저의 중첩이 생기면서 가독성과 유지보수성이 떨어졌습니다.
- 해결방안
메소드를 사용해서 코드를 분리했습니다.
또한, body / content / 메소드 세가지의 역할을 구분하여 프로젝트 내부에서 동일한 규칙을 준수하며 코드를 구현했습니다.
1. body - 뷰의 전체적인 설정
```swift
var body: some View {
    if isLoading || dataSource.isEmpty {
        LoadingView(isLoading: $isLoading)
    } else {
        content
    }
}
```
3. content - 해당 뷰를 이루고 있는 뷰 요소들
```swift
var content: some View {
    NavigationView {
        cityListView()
    }
}
```
5. 메소드 - 하위 뷰 생성
```swift    
func makeNavigationLink(of weather: CityWeather) -> some View {
    NavigationLink {
        WeatherDetailView(cityWeather: weather)
    } label: {
        CityRowView(cityWeather: weather)
    }
}
```

### View에서부터 ViewModel 분리
- 문제
초기 구현에서 뷰는 @EnvironmentState로 뷰모델 객체를 가지고 있었습니다.
- 해결방안
뷰와 뷰모델의 독립성을 지키고, 뷰에서는 뷰를 그리는 역할만 할 수 있도록 뷰모델을 분리했습니다. 
뷰는 오직 바인딩된 객체만을 이용해서 뷰를 구성할 수 있게 되었고, 뷰의 재사용성을 향상시켰습니다.

### PreViews의 활용
- Localization이 적용된 뷰를 PreView를 통해 한번에 확인할 수 있도록 `.environment`를 사용했습니다. 국가코드를 id로 한 `ForEach` 함수를 적용했습니다.
```swift
static var previews: some View {
        ForEach(["ko", "en"], id: \.self) { id in
            CityListView(isLoading: false, dataSource: .constant(CityWeather.mockData))
                .environment(\.locale, .init(identifier: id))
        }
    }
```

### 이미지의 Localization
- 로딩화면에서 노출되는 타이틀 이미지의 폰트가 한글이기 때문에 Localization이 필요했습니다.
- Asset에서의 Localization메뉴를 통해 영어 이미지도 함께 적용하였습니다.
