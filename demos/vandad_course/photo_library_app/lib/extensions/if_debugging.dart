import 'package:flutter/foundation.dart' show kDebugMode;

/// Extension IfDebugging.
extension IfDebugging on String {
  /// A way to pre-populate our text fields.
  String? get ifDebugging => kDebugMode ? this : null;
}
