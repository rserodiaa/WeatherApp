# WeatherApp
This project is a demosntration of SwiftUI and Combine and shows weather reports of various Cities along with daily forecast of upcoming days and also various weather attributes like humidity, wind, air pressure, etc.

## Design Pattern Used
This project follows a clean **MVVM architecture** with a **Repository pattern**, offering a modular, testable, and scalable approach.
**Repository Pattern**
All data operations are centralized in Repository, which can acts as a bridge between viewmodel and following services:
- Storage Layer (WeatherStorageServiceProtocol) – handles Core Data operations.
- Network Layer (WeatherServiceProtocol) – handles fetching weather details, AQI and pollution components.

## Features

### City Weather Overview

- Shows current weather for all tracked cities.
- Displays real-time weather of tracked cities using pagination.
- Dynamic icons representing current weather conditions.

### Forecast Page

- 5-day daily weather forecast per city.
- Includes details like:
  - Temperature
  - Humidity
  - Wind Speed
  - Air Pressure
  - Precipitation

  **Pollution Widget:**

  - Shows real-time AQI and pollution levels. User can access AQI detail on pollution widget on 5 Days Forecast page.
  - Tap to toggle and reveal detailed pollutant components (e.g., SO₂, NO₂).


### City List Operations

- Add new city using the "+" icon in the navigation bar.
- Swipe left to delete a city from local storage (**Core Data**).

## Testing
- Unit tests written using the **Swift Testing framework**.
- Includes test coverage for:
  - View Models
  - Repository layer
  - Storage service
- **Dependencies are mocked** for isolation and deterministic testing.

## Dependencies & Frameworks

- **SwiftUI** – Declarative UI
- **Combine** – Asynchronous data streams and reactive programming
- **Core Data** – Local persistence
- **SDWebImageSwiftUI** – Remote image loading (via SPM)

## APIs Used

- [OpenWeather API](https://openweathermap.org/api) – For current weather and forecast data (fetched using **Combine**)
- [AirVisual API](https://api.airvisual.com) – For real-time AQI and pollution details

## Upcoming Features
- Animated effects for weather conditions

## Language used 
Swift 5.0

## App Screenshots

<a href="url"><img src="https://github.com/user-attachments/assets/c320ebc9-db6b-4834-ab8d-07f749d68275" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/b7caeb6c-ba9b-4346-933a-b5927f8ac1c3" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/8bafe372-77c6-43e0-af37-03c4f3f3c936" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/db18a31e-604c-4ce9-b639-dad29b349048" align="left" height="350"></a>
<br clear="left"><br>
<a href="url">
  <img src="https://github.com/user-attachments/assets/5feef65a-bcc9-4d7c-ac36-ac2a43a86cb7" height="500" style="margin-right:100px;">
</a>
<a href="url">
  <img src="https://github.com/user-attachments/assets/6f1ae78a-83de-418d-8593-0bf290daf902" height="500">
</a>

