import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// The tint an [Avatar]'s fallback resolves against.
enum AvatarTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// A person is a circle and a thing is a square — a project, a repository.
enum AvatarShape { circle, square }

/// The picture that stands for a person or a project.
///
/// What it is really for is the case where there is no picture: the initials
/// are drawn until the image has actually decoded, so a slow or broken URL
/// never flashes an empty box.
///
/// It is not interactive and stays off [Pressable] — it reads the `tinted`
/// recipe's resting colours directly. An avatar that lit up under the pointer
/// would read as something you can press.
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.image,
    this.name,
    this.fallback,
    this.size = WidgetSize.medium,
    this.shape = AvatarShape.circle,
    this.tint = AvatarTint.primary,
  });

  /// The picture. Until it decodes, and if it never does, the fallback shows.
  final ImageProvider? image;

  /// Who or what this is. It names the avatar to a screen reader and, unless
  /// [fallback] says otherwise, it is where the initials come from.
  final String? name;

  /// Drawn in place of the picture. Defaults to the initials of [name].
  final Widget? fallback;

  final WidgetSize size;

  final AvatarShape shape;

  final AvatarTint tint;

  /// Initials: the first letter of the first word and of the last, which is
  /// the pair a reader actually recognises. One word gives one letter rather
  /// than two off the same word, since "Ac" for Acme reads as a truncation
  /// rather than as a monogram.
  static String initialsOf(String name) {
    final List<String> words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    if (words.isEmpty) return '';
    final String first = words.first.characters.first;
    final String last = words.length > 1 ? words.last.characters.first : '';
    return (first + last).toUpperCase();
  }

  /// The box, per size. Off the 4px grid rather than off the control profile:
  /// an avatar is not a control, and these are the steps a row, a header and a
  /// card actually ask for.
  static double dimensionOf(ThemeVariables vars, WidgetSize size) {
    return switch (size.namedSize) {
      NamedSize.large => vars.spacing9,
      NamedSize.medium => vars.spacing7,
      _ => vars.spacing5,
    };
  }

  ColorSwatch<int> _ramp(ThemeVariables vars) {
    return switch (tint) {
      AvatarTint.primary => vars.colorPrimary,
      AvatarTint.neutral => vars.colorNeutral,
      AvatarTint.info => vars.colorInfo,
      AvatarTint.success => vars.colorSuccess,
      AvatarTint.warning => vars.colorWarning,
      AvatarTint.danger => vars.colorDanger,
    };
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final double dimension = dimensionOf(vars, size);
    final ColorSwatch<int> ramp = _ramp(vars);

    // The square takes the container corner rather than the control corner. An
    // avatar is a thing rather than something you press, and under Bright —
    // where the control corner is a pill — a control-cornered square would go
    // round and stop being the shape that says "project".
    final BorderRadius radius = shape == AvatarShape.circle
        ? BorderRadius.circular(vars.radiusFull)
        : BorderRadius.circular(vars.radiusMedium);

    // The type moves one step of the scale per size — 11, 12, 13 — rather than
    // tracking the box, which grows nearly twice as fast: two letters at a
    // third of a 36px circle would fill it edge to edge.
    final TextStyle label = switch (size.namedSize) {
      NamedSize.large => vars.labelLarge,
      NamedSize.medium => vars.labelMedium,
      _ => vars.captionSmall,
    };

    final Widget mark =
        fallback ??
        (name == null ? const SizedBox.shrink() : Text(initialsOf(name!)));

    return Semantics(
      label: name,
      image: true,
      child: Container(
        width: dimension,
        height: dimension,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: radius,
          // The fallback fills the whole box rather than sitting behind the
          // image, so a transparent PNG lands on the tint rather than on
          // whatever is behind the avatar.
          color: ramp[vars.controlColorTintedSurface.normalShade!]!.withValues(
            alpha: vars.controlColorTintedSurface.normalOpacity,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: DefaultTextStyle.merge(
                style: vars.labelStrong.copyWith(
                  fontSize: label.fontSize,
                  height: 1,
                  color: ramp[vars.controlColorTintedContentNormalShade]!,
                ),
                child: mark,
              ),
            ),
            if (image != null) Image(image: image!, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

/// A run of avatars, overlapped.
///
/// Each one is cut out of the one before it, so the stack reads as a group
/// rather than as a smear. The cut is drawn as a ring that spreads outside the
/// box rather than as a border, so it takes no room — the same thing the
/// stylesheet's `box-shadow: 0 0 0 1.5px` does, and for the same reason: a
/// border would grow every avatar in the run by three pixels.
class AvatarGroup extends StatelessWidget {
  const AvatarGroup({
    super.key,
    this.max,
    this.size = WidgetSize.medium,
    this.shape = AvatarShape.circle,
    this.ring,
    required this.children,
  });

  /// How many to draw before the rest become a count. Omit to draw them all.
  final int? max;

  /// The size the avatars inside are drawn at. The group does not set it on
  /// them — each one carries its own — but the overlap, the ring and the count
  /// chip are measured from it, and they have no other way to know.
  final WidgetSize size;

  /// The shape the avatars inside are drawn in, for the same reason as [size]:
  /// the ring is cut around them and has to follow their corner.
  final AvatarShape shape;

  /// The colour each avatar is cut out of its neighbour with. Defaults to the
  /// paper a group usually sits on; a group on a card passes the card's own
  /// surface.
  final Color? ring;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final double dimension = Avatar.dimensionOf(vars, size);
    final Color cut = ring ?? vars.colorSurface;
    final BorderRadius radius = shape == AvatarShape.circle
        ? BorderRadius.circular(vars.radiusFull)
        : BorderRadius.circular(vars.radiusMedium);

    // A third of the box, on every size — a fixed overlap would swallow a
    // small avatar and barely touch a large one.
    final double overlap = switch (size.namedSize) {
      NamedSize.large => vars.spacing3,
      NamedSize.medium => vars.spacing2,
      _ => vars.spacing15,
    };

    final List<Widget> shown = max == null
        ? children
        : children.take(max!).toList();
    final int hidden = children.length - shown.length;

    final List<Widget> run = [
      ...shown,
      if (hidden > 0)
        // The overflow count wears the same box in the neutral groove rather
        // than a tint: it is a number, not a person.
        Container(
          width: dimension,
          height: dimension,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: vars.colorSurfaceSunken,
          ),
          child: Text(
            '+$hidden',
            style: vars.labelStrong.copyWith(
              fontSize: size.namedSize == NamedSize.large
                  ? vars.labelMedium.fontSize
                  : vars.captionSmall.fontSize,
              height: 1,
              color: vars.colorContentMuted,
            ),
          ),
        ),
    ];

    if (run.isEmpty) return const SizedBox.shrink();

    final double step = dimension - overlap;
    final double width = dimension + step * (run.length - 1);

    // A Stack rather than a Row: the overlap is negative, and Flutter's
    // padding and margins are both asserted non-negative.
    return SizedBox(
      width: width,
      height: dimension,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int index = 0; index < run.length; index += 1)
            PositionedDirectional(
              start: step * index,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  boxShadow: [
                    BoxShadow(color: cut, spreadRadius: vars.strokeControl),
                  ],
                ),
                child: run[index],
              ),
            ),
        ],
      ),
    );
  }
}
