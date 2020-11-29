cmd /c flutter clean
cmd /c flutter pub get
cmd /c flutter packages pub run build_runner build --delete-conflicting-outputs -v