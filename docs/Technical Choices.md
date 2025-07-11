## Architecture

**Clean Architecture.**
	for scalability, readability and maintainability.

---
## State Management & Dependency Injection

**`riverpod`**
	for simplicity and minimality.

---
## Navigation

**`go_router`**
	for technical familiarity with the current staff.

---
## Local Storage

- **`drift`** - for relational data storage.
- **`shared_preferences`** - for simple data storage like app settings or user preferences.
- **`flutter_secure_storage`** - for storing sensitive data (e.g. user data, tokens, passwords) if any.

---
## Notifications

**`flutter_local_notifications`**
	It just works! especially for iOS.

---
# Timezone

- **`flutter_timezone`** - easily fetch local timezone.
- **`timezone`** - timezone database
	***Note:***
	to initialize timezones use the following code:
	```dart
	import 'package:timezone/data/latest.dart' as tz;
	void main(){
	  tz.initializeTimeZones();
	}
	```
	to avoid platform specific errors use the following library: `import 'package:timezone/standalone.dart' as tz;`. This lib is specific for Android and iOS.
---
## Permissions

**`permission_handler`**

---
# Analytics & Crash reports

- **`posthog_flutter`** - Analytics.
- **`sentry_flutter`** - Crash reports.