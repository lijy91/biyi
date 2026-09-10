import 'package:flutter/widgets.dart';

import '../services/runtime.dart' show ProviderType;
import '../theme/product_tokens.dart' show ProductTokens, ProductTypography;
import 'provider_icon/provider_icon.dart' show ProviderIcon;
import 'ui.dart' show SectionLabel, ThemeDataBuildContextProps;

/// The brand colours the deck gives its services, by position in the list —
/// the same order the ⌥n hints count in.
const List<Color> kProviderAvatarColors = [
  ProductTokens.providerBuiltin,
  ProductTokens.providerClaude,
  ProductTokens.providerDeepl,
  ProductTokens.providerDict,
];

/// One candidate service in a result block's 对比 list — two rows: the
/// attribution, then the text. The list is there to be read, not chosen from:
/// the row carries no 设为首选 and no ⌥n hint, a glossary conflict is left to
/// the marks in the text rather than a further row of buttons, and the card
/// frame is gone, so the list lies directly on the block's tinted surface
/// instead of cutting the output area into pieces.
class CandidateRow extends StatelessWidget {
  const CandidateRow({
    super.key,
    required this.name,
    required this.providerType,
    required this.child,
  });

  /// What the service is called on screen — [serviceDisplayName]'s answer, the
  /// same string 服务 lists it under.
  final String name;

  /// The provider behind the service, drawn as its own mark. Null falls back
  /// to the system glyph: a service whose provider is gone still has a row,
  /// and a lettered disc in its place would invent an identity for it.
  final ProviderType? providerType;

  /// The translation, or what stands in for it while the service works.
  final Widget child;

  /// The attribution chip hangs 6px past the text column on each side, as
  /// the deck's `-mx-1.5` does, so the name lines up with the text below
  /// while the hover wash still wraps it.
  static const double chipInset = 6;

  @override
  Widget build(BuildContext context) {
    final vars = context.vars;

    final header = Row(
      children: [
        // The provider's own mark, at the size 服务 draws it — the row names
        // a service, so it is marked the way that service is everywhere else.
        ProviderIcon(providerType ?? ProviderType.system, size: 16),
        const SizedBox(width: 7),
        Expanded(
          child: SectionLabel(name),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: chipInset,
              vertical: 4,
            ),
            child: header,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: chipInset),
            child: DefaultTextStyle(
              style: vars.cjkStyle(
                fontSize: 13,
                height: 1.7,
                color: vars.colorContentSecondary,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
