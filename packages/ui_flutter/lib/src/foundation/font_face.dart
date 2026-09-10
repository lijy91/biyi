import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// One of the design's type faces, as the two things Flutter can be told
/// about a family.
///
/// The faces are declared as CSS stacks — `-apple-system, SF Pro Text,
/// system-ui, PingFang SC, sans-serif` — and a stack is not something
/// Flutter takes. What it takes is a family and a list to fall back
/// through, so the stack is split: the keywords that name the platform's own
/// UI face leave [family] null, which is Flutter's way of saying "the
/// platform default", and the concrete faces behind them become [fallback].
///
/// It is a field on `ThemeVariables` rather than a literal inside each type
/// style so that a host can re-point it — `vars.copyWith(fontUi: ...)` —
/// and have every style built from that face follow. A design system that
/// asks for the platform's own face is right on a Mac and has nothing to say
/// on Windows, in a Flutter test, or in an app that ships its own font.
@immutable
class FontFace {
  const FontFace({
    this.family,
    this.fallback = const <String>[],
  });

  /// The family to set, or null for the platform's own UI face.
  final String? family;

  /// The families to fall through when [family] has no glyph — or, when
  /// [family] is null, the ones the platform default falls through to.
  final List<String> fallback;

  FontFace copyWith({
    String? family,
    List<String>? fallback,
  }) {
    return FontFace(
      family: family ?? this.family,
      fallback: fallback ?? this.fallback,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FontFace &&
        other.family == family &&
        listEquals(other.fallback, fallback);
  }

  @override
  int get hashCode => Object.hash(family, Object.hashAll(fallback));

  @override
  String toString() => 'FontFace(family: $family, fallback: $fallback)';
}

/// Sets a style in one of the design's faces.
///
/// A `TextStyle` takes a family and a fallback list where the graph declares
/// one stack, so every reach for a face is these two lines. It is an extension
/// rather than a helper on [FontFace] because what a caller has is the style
/// they are building.
extension FontFaceTextStyle on TextStyle {
  TextStyle inFace(FontFace face) {
    return copyWith(
      fontFamily: face.family,
      fontFamilyFallback: face.fallback,
    );
  }
}
