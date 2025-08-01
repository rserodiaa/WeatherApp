# WeatherApp
This project is a demosntration of SwiftUI and shows weather reports of various Cities along with daily forecast of upcoming days and also various weather attributes like humidity, wind, air pressure, etc.

## Design Pattern Used
This project follows a clean **MVVM architecture** with a Repository pattern, offering a modular, testable, and scalable approach.
**Repository Pattern**
All data operations are centralized in Repository, which can acts as a bridge between:
- Storage Layer (WeatherStorageServiceProtocol) – handles Core Data operations.
- Network Layer (WeatherServiceProtocol) – handles fetching weather details, AQI and pollution components.
  
# Features
- Shows current weather of cities tracked by user.
- Daily Forecast for next 5 days.
- Capability to add new cities and persist using core data.
- Shows real time weather of multiple cities using pagination.
- Pollution Level and AQI details.
- Dynamic icons representing current weather conditions.

  - **City List Operations:**
    - Add City on click of '+' icon on nav bar.
    - Swipe left any city row will allow to delete the row from core data.
 
  - **Pollution Widget:**
    - User can access AQI detail on pollution widget on 5 Days Forecast page.
    - Tapping on card can toggle the card to show the dynamic pollution components.

# Upcoming Features
- Animated effects for weather conditions

## Testing
- Unit tests written using **Swift Testing** to ensure core functionality.
- Added test cases for important layers like repository and view models while mocking related dependancies.

# Resourses/Framework
- SDWebImageSwiftUI using SPM
- Free Weather API "https://openweathermap.org/api"
- Free Pollution AQI "https://api.airvisual.com"

# Language used 
Swift 5.0

# App Screenshots


<a href="url"><img src="https://github.com/user-attachments/assets/c320ebc9-db6b-4834-ab8d-07f749d68275" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/17c0c52b-85e6-4ba4-9574-612407787e6f" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/8bafe372-77c6-43e0-af37-03c4f3f3c936" align="left" height="350"></a>
<a href="url"><img src="https://github.com/user-attachments/assets/db18a31e-604c-4ce9-b639-dad29b349048" align="left" height="350"></a>

