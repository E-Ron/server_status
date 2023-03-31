# Minecraft server status
 
### Deployment
```
https://limitedasm.github.io/minecraft_server_status
```

### Hot-reloads for development
```
flutter run lib/main.dart --dart-define=MINECRAFT_SERVER_IP=<IP>
```

### Build android
```
flutter build apk lib/main.dart --dart-define=MINECRAFT_SERVER_IP=<IP>
```

### Build web
```
flutter build web lib/main.dart --dart-define=MINECRAFT_SERVER_IP=<IP>
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
