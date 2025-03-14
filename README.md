# Shimmer Package for Flutter

A lightweight and highly customizable shimmer effect package for Flutter applications.

## Features

- Easy-to-use shimmer effect for loading placeholders.
- Customizable shimmer color, direction, and duration.
- Supports different shapes like rectangles, circles, and more.
- Lightweight and optimized for performance.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  shimmer_package:
    git:
      url: https://github.com/dilrabo-vic24/shimmer_loading_placeholder.git
```

Then, run:

```sh
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:shimmer_loading_placeholder_new1';
```

Wrap your widget with `ShimmerEffect`:

```dart
ShimmerEffect(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(
    width: 200,
    height: 100,
    color: Colors.white,
  ),
)
```

## Customization

You can customize the shimmer effect with the following parameters:

- `baseColor`: Background color of the shimmer effect.
- `highlightColor`: The color that moves across the shimmer.
- `direction`: Controls the shimmer animation direction (left-to-right, top-to-bottom, etc.).
- `duration`: Defines how fast the shimmer effect moves.

## Example

```dart
ShimmerEffect(
  baseColor: Colors.blueGrey,
  highlightColor: Colors.white,
  direction: ShimmerDirection.ltr,
  duration: Duration(seconds: 2),
  child: Container(
    width: double.infinity,
    height: 100,
    color: Colors.white,
  ),
)
```

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any issues or feature requests, please create an issue on the repository.