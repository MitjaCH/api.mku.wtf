# api.mku.wtf

## **Class Structure**

### **Entities (Data Models)**

1. **`UtilityEntity`** (Base model for all utilities)
   - `id`: Integer (Primary Key)
   - `name`: String (Unique name for the utility, e.g., "URL Shortener")
   - `description`: String (Description of the utility)
   - `endpoint`: String (The API endpoint that provides the utility)
   - `type`: Enum (Utility type, e.g., `URL_SHORTENER`, `TEXT_GENERATOR`, etc.)

2. **`UrlShortenerEntity`** (Specific model for URL shortener utility)
   - `id`: Integer (Primary Key)
   - `shortCode`: String (Unique short code)
   - `originalUrl`: String (The original URL that the short code points to)
   - `createdAt`: DateTime (Timestamp for when the short URL was created)

---

### **Repositories (Data Access Layers)**

1. **`UtilityRepository`** (Handles database operations for utilities)
   - `findByName(name: String): UtilityEntity?`: Fetch a utility by its unique name
   - `findAll(): List<UtilityEntity>`: List all utilities

2. **`UrlShortenerRepository`** (Handles URL shortener-related database operations)
   - `findByShortCode(shortCode: String): UrlShortenerEntity?`: Fetch the original URL based on short code
   - `save(urlShortener: UrlShortenerEntity): UrlShortenerEntity`: Save new short codes

---

### **Services (Business Logic)**

1. **`UtilityService`** (General service for utilities)
   - `getUtilityByName(name: String): UtilityEntity?`: Fetch a utility by its name
   - `createUtility(name: String, description: String, endpoint: String): UtilityEntity`: Add a new utility
   - `listAllUtilities(): List<UtilityEntity>`: Get a list of all available utilities

2. **`UrlShortenerService`** (Handles URL shortener logic, as a specific type of utility)
   - `createShortCode(originalUrl: String, shortCode: String): UrlShortenerEntity`: Generate a short code for a URL
   - `getOriginalUrl(shortCode: String): String?`: Retrieve the original URL from the short code

---

### **Controllers (REST Endpoints)**

1. **`UtilityController`** (Handles API requests for utilities)
   - `GET /api/utility`: Fetch a list of all utilities
   - `POST /api/utility`: Add a new utility
   - `GET /api/utility/{name}`: Get details of a specific utility (e.g., "URL Shortener")

2. **`UrlShortenerController`** (Handles API requests specific to URL shortener)
   - `GET /api/shortener/{shortCode}`: Redirect or fetch the original URL from the short code
   - `POST /api/shortener`: Create a new short code

---

### **Utility Types (Enum)**

```kotlin
enum class UtilityType {
    URL_SHORTENER,
    TEXT_GENERATOR,
    QR_CODE_GENERATOR
}
```

---

### **Database Tables**

1. **`utilities`** (Stores general utilities):
   - `id`: Integer (Primary Key)
   - `name`: String (Unique utility name)
   - `description`: String
   - `endpoint`: String
   - `type`: String (Enum type)

2. **`url_shorteners`** (Stores short URLs):
   - `id`: Integer (Primary Key)
   - `shortCode`: String (Unique short code)
   - `originalUrl`: String
   - `createdAt`: Timestamp

---

### **Database Schema (SQL Example)**

```sql
CREATE TABLE utilities (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) UNIQUE NOT NULL,
  description VARCHAR(500) NOT NULL,
  endpoint VARCHAR(500) NOT NULL,
  type VARCHAR(50) NOT NULL
);

CREATE TABLE url_shorteners (
  id INT PRIMARY KEY AUTO_INCREMENT,
  short_code VARCHAR(255) UNIQUE NOT NULL,
  original_url VARCHAR(500) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

### **Relationships and Responsibilities**
- **One-to-One**: The `URL_SHORTENER` entry in the `utilities` table links to the `/api/shortener` endpoint.
- **One-to-Many**: The `url_shorteners` table stores multiple short links under the "URL Shortener" utility.

---

### **Usage Example**

#### **Adding a Utility (URL Shortener)**
`POST /api/utility`
```json
{
  "name": "URL Shortener",
  "description": "Shortens long URLs to short codes",
  "endpoint": "/api/shortener",
  "type": "URL_SHORTENER"
}
```

#### **Creating a Short URL**
`POST /api/shortener`
```json
{
  "originalUrl": "https://www.google.com",
  "shortCode": "google123"
}
```

#### **Fetching the Original URL**
`GET /api/shortener/google123`
```json
"https://www.google.com"
```
