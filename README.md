# 오늘의 날씨 프로젝트
- OpenWeather API를 이용한 날씨 정보 앱 개발 프로젝트
- [기존 UIKit 프로젝트](https://github.com/horeng2/TodaysWeather)를 `Combine`/`SwiftUI`로 리팩토링

## 목차
- [키워드](##키워드)
- [프로젝트 소개](##프로젝트_소개)
- [주요 기능](##주요_기능)
- [시도해본 점](##시도해본_점)
- [Trouble Shooting](##Trouble_Shooting)
- [새롭게 알게 된 것](##새롭게_알게_된_것)

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

## 🗂 디렉토리 구조
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
## 기능
- 한국어

|초기 화면|동작 화면|
| :-: | :-: |
|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 45 20](https://user-images.githubusercontent.com/87305744/190971560-24064149-badd-4efc-8756-744052d8e065.gif)|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 01 14](https://user-images.githubusercontent.com/87305744/190969998-9b4e1c20-f444-4c0a-849c-3fd683e44675.gif)|

- 영어

|초기 화면|동작 화면|
| :-: | :-: |
|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 02 15](https://user-images.githubusercontent.com/87305744/190969964-d78b2452-2010-4ee2-b736-02a26ed6f171.gif)|![Simulator Screen Recording - iPhone 13 - 2022-09-19 at 16 04 12](https://user-images.githubusercontent.com/87305744/190970118-aa1467ac-4721-4766-a93f-80e2ed39f42b.gif)|


## 시도해본 점
- DIContainer
로딩화면, 로딩 애니메이션
프리뷰에서 바인딩 객체값 지정
DIContainer

## 고민점
프리뷰에서 다국어 여러개 보는 것
길어지는 코드
SwiftUI에서의 MVVM
재사용성 확장을 위해 뷰에서부터 뷰모델 분리
## Trouble Shooting
## 새롭게 알게 된 것
