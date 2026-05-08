# Simple Dice App 🎲

A beautiful and interactive Flutter application that simulates rolling a dice with random numbers from 1 to 6.

## Features ✨

- **Visual Dice Display**: Shows dice images (1.png to 6.png) representing numbers 1-6
- **Interactive Rolling**: Tap the dice image or press the "Roll Dice" button to roll
- **Smooth Animations**: Rotating dice animation during rolls for better UX
- **Responsive Design**: Works seamlessly on different screen sizes
- **Clean UI**: Modern gradient background with intuitive layout
- **Well-Documented Code**: Each section has comments explaining functionality
- **Professional Typography**: Uses Poppins and Roboto fonts for clean appearance

## Project Structure 📁

```
Simple_Dice_App/
├── lib/
│   └── main.dart                 # Main app file with all logic
├── assets/
│   └── images/
│       ├── 1.png                 # Dice face with 1 dot
│       ├── 2.png                 # Dice face with 2 dots
│       ├── 3.png                 # Dice face with 3 dots
│       ├── 4.png                 # Dice face with 4 dots
│       ├── 5.png                 # Dice face with 5 dots
│       └── 6.png                 # Dice face with 6 dots
├── pubspec.yaml                  # Project configuration and dependencies
└── README.md                      # This file
```

## How It Works 🔧

### Main Components:

1. **SimpleDiceApp**: Root widget that configures the app theme and navigation
2. **DiceRollerScreen**: Main UI screen displaying the dice
3. **_DiceRollerScreenState**: Manages the current dice number and animation state

### Key Functions:

- `_rollDice()`: 
  - Generates a random number between 1 and 6
  - Updates the state with `setState()` to trigger UI rebuild
  - Plays the rotation animation

### Random Number Generation:

```dart
int newNumber = _random.nextInt(6) + 1;
```

This generates a number from 1 to 6 using Dart's Random class.

## State Management 📊

The app uses Flutter's `setState()` function to manage state:

```dart
setState(() {
  _currentDiceNumber = newNumber;
});
```

When the dice number changes, `setState()` rebuilds the widget with the new dice image.

## Assets 🎨

The dice images (1.png to 6.png) are:
- Located in `assets/images/` directory
- Registered in `pubspec.yaml`
- Each shows the corresponding number of white dots on a colored background

## UI Design 🎨

- **Gradient Background**: Beautiful gradient from Indigo to Pink
- **Responsive Layout**: Uses `MediaQuery` for screen adaptation
- **Interactive Feedback**: Tap gesture detection on dice image
- **Animations**: Smooth rotation animation during dice roll
- **Shadows**: Material shadow effects for depth
- **Typography**: Uses Poppins font for modern appearance

## How to Run 🚀

### Prerequisites:
- Flutter SDK installed
- Android/iOS emulator or device connected

### Steps:

1. Navigate to the project directory:
   ```
   cd Simple_Dice_App
   ```

2. Get dependencies:
   ```
   flutter pub get
   ```

3. Run the app:
   ```
   flutter run
   ```

4. To build APK:
   ```
   flutter build apk --release
   ```

## Code Highlights 💡

### Animation Setup:
```dart
_animationController = AnimationController(
  duration: const Duration(milliseconds: 500),
  vsync: this,
);
```

### Dice Rolling:
```dart
void _rollDice() {
  int newNumber = _random.nextInt(6) + 1;
  
  setState(() {
    _currentDiceNumber = newNumber;
  });
  
  _animationController.forward(from: 0.0);
}
```

### Interactive Dice:
```dart
GestureDetector(
  onTap: _rollDice,
  child: RotationTransition(
    turns: _rotationAnimation,
    child: Image.asset('assets/images/$_currentDiceNumber.png'),
  ),
)
```

## Learning Points 📚

This app demonstrates:
- Basic Flutter widgets and layouts
- State management with `setState()`
- Animation in Flutter
- Asset management in `pubspec.yaml`
- Gesture detection (tap)
- Random number generation
- Responsive design
- Code organization and comments

## Game Instructions 🎮

1. Open the app to see the initial dice (showing 1)
2. Tap the large dice image to roll it
3. Alternatively, tap the "Roll Dice" button below the dice
4. Watch the dice rotate and display a random number
5. The number displayed below the dice updates automatically
6. Repeat as many times as you want!

## Customization Ideas 🔧

Feel free to extend this app with:
- Sound effects when rolling
- Roll counter to track total rolls
- Best number statistics
- Vibration feedback on roll
- Dark/Light theme toggle
- Multiplayer functionality
- Different dice styles

## Version Information 📌

- **App Version**: 1.0.0
- **Dart SDK**: 3.11.5+
- **Flutter**: Latest stable

## Author Notes ✍️

This is a beginner-friendly Flutter app designed to teach:
- Basic widget creation
- State management fundamentals
- Asset management
- Simple animations
- User interaction handling

## License 📄

This project is open source and available for educational purposes.

---

**Happy Rolling! 🎲**
