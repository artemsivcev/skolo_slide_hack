The application was created for the  Flutter Puzzle Hack by the Skolopendra company team (https://skolopendra.com).

After the downloading the project run the command to run code generation:
flutter packages pub run build_runner build --delete-conflicting-outputs
Or just run a cleanAndRebuild.sh script.

Supported platforms:
Android
IOS
Web
macOS (without an ability to use your own image)
Notice, the app has not been tested on Windows and Linux.

Functionality:
Playing with your own image
Playing with the app’s default image
Playing without image
Sound effects and music
Counting the number of moves that were made to win
Showing spent time to resolve puzzle
Adaptive UI
Rich animation

Technical aspects:
State management made by using MobX.
get_it is used as service locator
