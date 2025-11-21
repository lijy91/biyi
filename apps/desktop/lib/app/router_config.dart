import 'package:biyi_app/app/available_ocr_engines/page.dart';
import 'package:biyi_app/app/available_translation_engines/page.dart';
import 'package:biyi_app/app/home/page.dart';
import 'package:biyi_app/app/record_shortcut/page.dart';
import 'package:biyi_app/app/settings/about/page.dart';
import 'package:biyi_app/app/settings/advanced/page.dart';
import 'package:biyi_app/app/settings/appearance/page.dart';
import 'package:biyi_app/app/settings/general/page.dart';
import 'package:biyi_app/app/settings/keybinds/page.dart';
import 'package:biyi_app/app/settings/language/page.dart';
import 'package:biyi_app/app/settings/layout.dart';
import 'package:biyi_app/app/settings/ocr_engine_types/page.dart';
import 'package:biyi_app/app/settings/ocr_engines/new/page.dart';
import 'package:biyi_app/app/settings/ocr_engines/page.dart';
import 'package:biyi_app/app/settings/page.dart';
import 'package:biyi_app/app/settings/translation_engine_types/page.dart';
import 'package:biyi_app/app/settings/translation_engines/new/page.dart';
import 'package:biyi_app/app/settings/translation_engines/page.dart';
import 'package:biyi_app/app/settings/translation_targets/new/page.dart';
import 'package:biyi_app/app/supported_languages/page.dart';
import 'package:biyi_app/models/translation_target.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';

class PageId {
  static const String availableOcrEngines = '/available-ocr-engines';
  static const String availableTranslationEngines =
      '/available-translation-engines';
  static const String home = '/home';
  static const String settingsOcrEnginesNew = '/settings/ocr-engines/new';
  static const String settingsGeneral = '/settings/general';
  static const String settingsAppearance = '/settings/appearance';
  static const String settingsKeybinds = '/settings/keybinds';
  static const String settingsLanguage = '/settings/language';
  static const String settingsAdvanced = '/settings/advanced';
  static const String settingsTranslationEngineTypes =
      '/settings/translation-engine-types';
  static const String settingsTranslationEngines =
      '/settings/translation-engines';
  static const String settingsOcrEngineTypes = '/settings/ocr-engine-types';
  static const String settingsOcrEngines = '/settings/ocr-engines';
  static const String settingsAbout = '/settings/about';
  static const String supportedLanguages = '/supported-languages';
  static const String settingsTranslationEnginesNew =
      '/settings/translation-engines/new';
  static const String translationTargetsNew =
      '/settings/translation-targets/new';
  static String settingsOcrEngine(String id) => '/settings/ocr-engines/$id';
  static String settingsTranslationEngine(String id) =>
      '/settings/translation-engines/$id';
  static String settingsTranslationTarget(String id) =>
      '/settings/translation-targets/$id';
}

// GoRouter configuration
final routerConfig = GoRouter(
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return '/home';
      },
    ),
    GoRoute(
      path: '/available-ocr-engines',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return DialogPage(
          builder: (_) => AvailableOcrEnginesPage(
            selectedEngineId: state.uri.queryParameters['selectedEngineId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/available-translation-engines',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return DialogPage(
          builder: (_) => AvailableTranslationEnginesPage(
            selectedEngineId: state.uri.queryParameters['selectedEngineId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: '/record-shortcut',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return DialogPage(
          builder: (_) => const RecordShortcutPage(),
        );
      },
    ),
    ShellRoute(
      pageBuilder: (context, state, child) {
        return FadeTransitionPage(
          key: state.pageKey,
          child: SettingsLayout(child: child),
        );
      },
      routes: [
        GoRoute(
          path: '/settings',
          redirect: (context, state) {
            return null;
          },
          builder: (UniPlatform.isAndroid || UniPlatform.isIOS)
              ? (context, state) {
                  return const SettingsPage();
                }
              : null,
          routes: [
            GoRoute(
              path: 'about',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const AboutSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'advanced',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const AdvancedSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'appearance',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const AppearanceSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'general',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const GeneralSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'keybinds',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const KeybindsSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'language',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const LanguageSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'ocr-engine-types',
              builder: (context, state) {
                return const OcrEngineTypesPage();
              },
            ),
            GoRoute(
              path: 'ocr-engines',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const OcrEnginesSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'ocr-engines/new',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return OcrEnginesNewOrEditPage(
                  ocrEngineType: extra?['ocrEngineType'],
                );
              },
            ),
            GoRoute(
              path: 'ocr-engines/:id',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return OcrEnginesNewOrEditPage(
                  ocrEngineConfig: extra?['ocrEngineConfig'],
                  editable: extra?['editable'],
                );
              },
            ),
            GoRoute(
              path: 'translation-engine-types',
              builder: (context, state) {
                return const TranslationEngineTypesPage();
              },
            ),
            GoRoute(
              path: 'translation-engines',
              pageBuilder: (context, state) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: const TranslationEnginesSettingPage(),
                );
              },
            ),
            GoRoute(
              path: 'translation-engines/new',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return TranslationEnginesNewOrEditPage(
                  engineType: extra?['engineType'],
                  editable: extra?['editable'],
                );
              },
            ),
            GoRoute(
              path: 'translation-engines/:id',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return TranslationEnginesNewOrEditPage(
                  engineConfig: extra?['engineConfig'],
                  editable: extra?['editable'],
                );
              },
            ),
            GoRoute(
              path: 'translation-targets/new',
              builder: (context, state) {
                return const TranslationTargetNewOrEditPage();
              },
            ),
            GoRoute(
              path: 'translation-targets/:id',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return TranslationTargetNewOrEditPage(
                  translationTarget: TranslationTarget(
                    id: extra?['id'],
                    sourceLanguage: extra?['sourceLanguage'],
                    targetLanguage: extra?['targetLanguage'],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/supported-languages',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return DialogPage(
          builder: (_) => const SupportedLanguagesPage(),
        );
      },
    ),
  ],
);

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return DialogRoute<T>(
      context: context,
      settings: this,
      alignment: Alignment.center,
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      builder: (BuildContext context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(64),
            constraints: const BoxConstraints(
              maxWidth: 480,
              maxHeight: 600,
            ),
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? Colors.neutral.shade800
                      : Colors.neutral.shade200,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.black.withOpacity(0.3),
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: builder(context),
              ),
            ),
          ),
        );
      },
      anchorPoint: anchorPoint,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      themes: themes,
    );
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
