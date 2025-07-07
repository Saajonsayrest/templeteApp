#!/bin/bash

echo "🧹 Cleaning project..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get


#flutter build ios
#echo "🍎 Installing iOS pods..."
#cd ios
#pod install
#cd ..

#open ios/Runner.xcworkspace  10

#Bundle Release
#flutter build appbundle --release




echo "✅ All done!"

