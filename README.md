# Server status

### About
Application for saving coordinates and checking server status   

### Deployment
https://limitedasm.github.io/server_status

### Hot-reloads for development
```
flutter run lib/main.dart --dart-define=SERVER_IP=<IP>
```

### Build android
```
flutter build apk lib/main.dart --dart-define=SERVER_IP=<IP>
```

### Build web
```
flutter build web lib/main.dart --dart-define=SERVER_IP=<IP>
```

### Update application icons
```
flutter pub run flutter_launcher_icons
```

### Firebase initialize / update
```
firebase login
flutterfire configure
```
