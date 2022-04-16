import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:window_manager/window_manager.dart';

import '../../../includes.dart';

import './limited_functionality_banner.dart';
import './toolbar_item_always_on_top.dart';
import './toolbar_item_settings.dart';
import './translation_input_view.dart';
import './translation_results_view.dart';
import './translation_target_select_view.dart';

const kMenuItemKeyQuickStartGuide = 'quick-start-guide';
const kMenuItemKeyQuitApp = 'quit-app';

const kMenuSubItemKeyJoinDiscord = 'subitem-join-discord';
const kMenuSubItemKeyJoinQQGroup = 'subitem-join-qq';

class DesktopPopupPage extends StatefulWidget {
  const DesktopPopupPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DesktopPopupPageState();
}

class _DesktopPopupPageState extends State<DesktopPopupPage>
    with
        WidgetsBindingObserver,
        ProtocolListener,
        ShortcutListener,
        TrayListener,
        WindowListener {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _bannersViewKey = GlobalKey();
  final GlobalKey _inputViewKey = GlobalKey();
  final GlobalKey _resultsViewKey = GlobalKey();

  Brightness _brightness = Brightness.light;
  Config _config = sharedConfigManager.getConfig();

  bool _showTrayIcon = sharedConfigManager.getConfig().showTrayIcon;
  String _appLanguage = sharedConfigManager.getConfig().appLanguage;

  Offset _lastShownPosition = Offset.zero;

  bool _isAllowedScreenCaptureAccess = true;
  bool _isAllowedScreenSelectionAccess = true;

  String _sourceLanguage = kLanguageEN;
  String _targetLanguage = kLanguageZH;
  bool _isShowSourceLanguageSelector = false;
  bool _isShowTargetLanguageSelector = false;

  bool _querySubmitted = false;
  String _text = '';
  String? _textDetectedLanguage;
  CapturedData? _capturedData;
  bool _isTextDetecting = false;
  ExtractedData? _extractedData;
  List<TranslationResult> _translationResultList = [];

  List<Future> _futureList = [];

  Timer? _resizeTimer;

  List<TranslationEngineConfig> get _translationEngineList {
    return sharedLocalDb.engines.list(
      where: (e) => !e.disabled,
    );
  }

  List<TranslationTarget> get _translationTargetList {
    if (_config.translationMode == kTranslationModeManual) {
      return [
        TranslationTarget(
          sourceLanguage: _sourceLanguage,
          targetLanguage: _targetLanguage,
        ),
      ];
    }
    return sharedLocalDb.translationTargets.list();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    sharedConfigManager.addListener(_configListen);
    if (kIsLinux || kIsMacOS || kIsWindows) {
      protocolHandler.addListener(this);
      ShortcutService.instance.setListener(this);
      trayManager.addListener(this);
      windowManager.addListener(this);
      _init();
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    sharedConfigManager.removeListener(_configListen);
    if (kIsLinux || kIsMacOS || kIsWindows) {
      protocolHandler.removeListener(this);
      ShortcutService.instance.setListener(null);
      trayManager.removeListener(this);
      windowManager.removeListener(this);
      _uninit();
    }
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    Brightness newBrightness =
        WidgetsBinding.instance!.window.platformBrightness;

    if (newBrightness != _brightness) {
      _brightness = newBrightness;
      if (kIsWindows && _config.showTrayIcon) {
        _initTrayIcon();
      }
      setState(() {});
    }
  }

  void _configListen() {
    Config newConfig = sharedConfigManager.getConfig();
    bool showTrayIcon = newConfig.showTrayIcon;
    String appLanguage = newConfig.appLanguage;

    bool trayIconUpdated =
        _showTrayIcon != showTrayIcon || _appLanguage != appLanguage;

    _config = newConfig;
    _showTrayIcon = showTrayIcon;
    _appLanguage = appLanguage;

    if (trayIconUpdated) _initTrayIcon();
    setState(() {});
  }

  void _init() async {
    if (kIsMacOS) {
      _isAllowedScreenCaptureAccess =
          await ScreenCapturer.instance.isAccessAllowed();
      _isAllowedScreenSelectionAccess =
          await screenTextExtractor.isAccessAllowed();
    }

    ShortcutService.instance.start();

    windowManager.waitUntilReadyToShow().then((_) async {
      if (kIsLinux || kIsWindows) {
        if (kIsLinux) {
          await windowManager.setAsFrameless();
        } else {
          await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
        }
        Display primaryDisplay = await screenRetriever.getPrimaryDisplay();
        Size windowSize = await windowManager.getSize();
        _lastShownPosition = Offset(
          (primaryDisplay.size.width / (primaryDisplay.scaleFactor ?? 1)) -
              windowSize.width -
              50,
          50,
        );
        await windowManager.setPosition(_lastShownPosition);
      }
      await windowManager.setSkipTaskbar(true);
      await Future.delayed(const Duration(milliseconds: 400));
      await _windowShow();
    });

    // 初始化托盘图标
    _initTrayIcon();
  }

  Future<void> _initTrayIcon() async {
    if (kIsWeb) return;

    String trayIconName =
        kIsWindows ? 'tray_icon_black.ico' : 'tray_icon_black.png';
    if (_brightness == Brightness.dark) {
      trayIconName = kIsWindows ? 'tray_icon.ico' : 'tray_icon.png';
    }

    await trayManager.destroy();
    if (_showTrayIcon) {
      await trayManager.setIcon(
        R.image(trayIconName),
        isTemplate: kIsMacOS ? true : false,
      );
      await Future.delayed(const Duration(milliseconds: 200));
      await trayManager.setContextMenu([
        MenuItem(
          title:
              '${'app_name'.tr()} v${sharedEnv.appVersion} (BUILD ${sharedEnv.appBuildNumber})',
          isEnabled: false,
        ),
        MenuItem.separator,
        MenuItem(
          key: kMenuItemKeyQuickStartGuide,
          title: 'tray_context_menu.item_quick_start_guide'.tr(),
        ),
        MenuItem(
          title: 'tray_context_menu.item_discussion'.tr(),
          items: [
            MenuItem(
              key: kMenuSubItemKeyJoinDiscord,
              title: 'tray_context_menu.item_discussion_subitem_discord_server'
                  .tr(),
            ),
            MenuItem(
              key: kMenuSubItemKeyJoinQQGroup,
              title: 'tray_context_menu.item_discussion_subitem_qq_group'.tr(),
            ),
          ],
        ),
        MenuItem.separator,
        MenuItem(
          key: kMenuItemKeyQuitApp,
          title: 'tray_context_menu.item_quit_app'.tr(),
        ),
      ]);
    }
  }

  void _uninit() {
    ShortcutService.instance.stop();
  }

  Future<void> _windowShow({
    bool isShowBelowTray = false,
  }) async {
    bool isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    Size windowSize = await windowManager.getSize();

    if (kIsLinux) {
      await windowManager.setPosition(_lastShownPosition);
    }

    if (kIsMacOS && isShowBelowTray) {
      Rect trayIconBounds = await trayManager.getBounds();
      Size trayIconSize = trayIconBounds.size;
      Offset trayIconnewPosition = trayIconBounds.topLeft;

      Offset newPosition = Offset(
        trayIconnewPosition.dx - ((windowSize.width - trayIconSize.width) / 2),
        trayIconnewPosition.dy,
      );

      if (newPosition != null && !isAlwaysOnTop) {
        await windowManager.setPosition(newPosition);
      }
    }

    bool isVisible = await windowManager.isVisible();
    if (!isVisible) {
      await windowManager.show();
    } else {
      await windowManager.focus();
    }

    // Linux 下无法激活窗口临时解决方案
    if (kIsLinux && !isAlwaysOnTop) {
      await windowManager.setAlwaysOnTop(true);
      await Future.delayed(const Duration(milliseconds: 100));
      await windowManager.setAlwaysOnTop(false);
      await Future.delayed(const Duration(milliseconds: 100));
      await windowManager.focus();
    }
  }

  Future<void> _windowHide() async {
    await windowManager.hide();
  }

  void _windowResize() {
    if (Navigator.of(context).canPop()) return;

    if (_resizeTimer != null && _resizeTimer!.isActive) {
      _resizeTimer?.cancel();
    }
    _resizeTimer = Timer.periodic(const Duration(milliseconds: 10), (_) async {
      if (!kIsMacOS) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      RenderBox? rb1 =
          _bannersViewKey.currentContext?.findRenderObject() as RenderBox?;
      RenderBox? rb2 =
          _inputViewKey.currentContext?.findRenderObject() as RenderBox?;
      RenderBox? rb3 =
          _resultsViewKey.currentContext?.findRenderObject() as RenderBox?;

      double toolbarViewHeight = 36.0;
      double bannersViewHeight = rb1?.size.height ?? 0;
      double inputViewHeight = rb2?.size.height ?? 0;
      double resultsViewHeight = rb3?.size.height ?? 0;

      try {
        double newWindowHeight = toolbarViewHeight +
            bannersViewHeight +
            inputViewHeight +
            resultsViewHeight +
            ((kVirtualWindowFrameMargin * 2) + 4);
        Size oldSize = await windowManager.getSize();
        Size newSize = Size(
          oldSize.width,
          newWindowHeight < _config.maxWindowHeight
              ? newWindowHeight
              : _config.maxWindowHeight,
        );
        if (oldSize.width != newSize.width ||
            oldSize.height != newSize.height) {
          await windowManager.setSize(newSize, animate: true);
        }
      } catch (error) {
        print(error);
      }

      if (_resizeTimer != null) {
        _resizeTimer?.cancel();
        _resizeTimer = null;
      }
    });
  }

  Future<void> _queryData() async {
    setState(() {
      _isShowSourceLanguageSelector = false;
      _isShowTargetLanguageSelector = false;
      _querySubmitted = true;
      _textDetectedLanguage = null;
      _translationResultList = [];
      _futureList = [];
    });

    if (_config.translationMode == kTranslationModeManual) {
      TranslationResult translationResult = TranslationResult(
        translationTarget: _translationTargetList.first,
        translationResultRecordList: [],
      );
      _translationResultList = [translationResult];
    } else {
      var filteredTranslationTargetList = _translationTargetList;
      try {
        DetectLanguageRequest detectLanguageRequest = DetectLanguageRequest(
          texts: [_text],
        );
        DetectLanguageResponse detectLanguageResponse =
            await sharedTranslateClient
                .use(sharedConfig.defaultEngineId)
                .detectLanguage(detectLanguageRequest);

        _textDetectedLanguage = detectLanguageResponse
            .detections!.first.detectedLanguage
            .split('-')[0];

        filteredTranslationTargetList = _translationTargetList
            .where((e) => e.sourceLanguage == _textDetectedLanguage)
            .toList();
      } catch (error) {
        print(error);
      }

      for (var translationTarget in filteredTranslationTargetList) {
        TranslationResult translationResult = TranslationResult(
          translationTarget: translationTarget,
          translationResultRecordList: [],
          unsupportedEngineIdList: [],
        );
        _translationResultList.add(translationResult);
      }

      setState(() {});
    }

    for (int i = 0; i < _translationResultList.length; i++) {
      TranslationTarget? translationTarget =
          _translationResultList[i].translationTarget;

      List<String> engineIdList = [];
      List<String> unsupportedEngineIdList = [];

      for (int j = 0; j < _translationEngineList.length; j++) {
        String identifier = _translationEngineList[j].identifier;

        if (_translationEngineList[j].disabled) continue;

        try {
          List<LanguagePair> supportedLanguagePairList = [];
          supportedLanguagePairList = await sharedTranslateClient
              .use(identifier)
              .getSupportedLanguagePairs();

          LanguagePair? languagePair = supportedLanguagePairList.firstWhere(
            (e) {
              return e.sourceLanguage == translationTarget?.sourceLanguage &&
                  e.targetLanguage == translationTarget?.targetLanguage;
            },
          );
          if (languagePair == null) {
            unsupportedEngineIdList.add(identifier);
          } else {
            engineIdList.add(identifier);
          }
        } catch (error) {
          engineIdList.add(identifier);
        }
      }

      _translationResultList[i].unsupportedEngineIdList =
          unsupportedEngineIdList;

      for (int j = 0; j < engineIdList.length; j++) {
        String identifier = engineIdList[j];

        TranslationResultRecord translationResultRecord =
            TranslationResultRecord(
          id: const Uuid().v4(),
          translationEngineId: identifier,
          translationTargetId: translationTarget?.id,
        );
        _translationResultList[i]
            .translationResultRecordList!
            .add(translationResultRecord);

        Future<bool> future = Future<bool>.sync(() async {
          LookUpRequest? lookUpRequest;
          LookUpResponse? lookUpResponse;
          UniTranslateClientError? lookUpError;
          if ((sharedTranslateClient.use(identifier).supportedScopes)
              .contains(kScopeLookUp)) {
            try {
              lookUpRequest = LookUpRequest(
                sourceLanguage: translationTarget!.sourceLanguage!,
                targetLanguage: translationTarget.targetLanguage!,
                word: _text,
              );
              lookUpResponse = await sharedTranslateClient
                  .use(identifier)
                  .lookUp(lookUpRequest);
            } on UniTranslateClientError catch (error) {
              lookUpError = error;
            } catch (error) {
              lookUpError = UniTranslateClientError(message: error.toString());
            }
          }

          TranslateRequest? translateRequest;
          TranslateResponse? translateResponse;
          UniTranslateClientError? translateError;
          if ((sharedTranslateClient.use(identifier).supportedScopes)
              .contains(kScopeTranslate)) {
            try {
              translateRequest = TranslateRequest(
                sourceLanguage: translationTarget!.sourceLanguage,
                targetLanguage: translationTarget.targetLanguage,
                text: _text,
              );
              translateResponse = await sharedTranslateClient
                  .use(identifier)
                  .translate(translateRequest);
            } on UniTranslateClientError catch (error) {
              lookUpError = error;
            } catch (error) {
              lookUpError = UniTranslateClientError(message: error.toString());
            }
          }

          if (lookUpResponse != null) {
            _translationResultList[i]
                .translationResultRecordList![j]
                .lookUpRequest = lookUpRequest;
            _translationResultList[i]
                .translationResultRecordList![j]
                .lookUpResponse = lookUpResponse;
          }
          if (lookUpError != null) {
            _translationResultList[i]
                .translationResultRecordList![j]
                .lookUpError = lookUpError;
          }

          if (translateResponse != null) {
            _translationResultList[i]
                .translationResultRecordList![j]
                .translateRequest = translateRequest;
            _translationResultList[i]
                .translationResultRecordList![j]
                .translateResponse = translateResponse;
          }
          if (translateError != null) {
            _translationResultList[i]
                .translationResultRecordList![j]
                .translateError = translateError;
          }

          setState(() {});

          return true;
        });
        _futureList.add(future);
      }
    }

    await Future.wait(_futureList);
  }

  void _handleTextChanged(
    String? newValue, {
    bool isRequery = false,
  }) {
    setState(() {
      // 移除前后多余的空格
      _text = (newValue ?? '').trim();
      // 当使用 Enter 键触发翻译时用空格替换换行符
      if (_config.inputSetting == kInputSettingSubmitWithEnter) {
        _text = _text.replaceAll('\n', ' ');
      }
    });
    if (isRequery) {
      _textEditingController.text = _text;
      _textEditingController.selection = TextSelection(
        baseOffset: _text.length,
        extentOffset: _text.length,
      );
      _handleButtonTappedTrans();
    }
  }

  void _handleExtractTextFromScreenSelection() async {
    ExtractedData extractedData =
        await screenTextExtractor.extractFromScreenSelection(
      useAccessibilityAPIFirst: false,
    );

    await _windowShow();
    await Future.delayed(const Duration(milliseconds: 100));

    _handleTextChanged(extractedData.text, isRequery: true);
  }

  void _handleExtractTextFromScreenCapture() async {
    setState(() {
      _querySubmitted = false;
      _text = '';
      _textDetectedLanguage = null;
      _capturedData = null;
      _isTextDetecting = false;
      _extractedData = null;
      _translationResultList = [];
    });
    _textEditingController.clear();
    _focusNode.unfocus();

    await _windowHide();

    String? imagePath;
    if (!kIsWeb) {
      Directory appDir = await sharedConfig.getAppDirectory();
      String fileName =
          'Screenshot-${DateTime.now().millisecondsSinceEpoch}.png';
      imagePath = '${appDir.path}/Screenshots/$fileName';
    }
    _capturedData = await ScreenCapturer.instance.capture(
      imagePath: imagePath,
    );

    await _windowShow();

    if (_capturedData == null) {
      BotToast.showText(
        text: 'page_home.msg_capture_screen_area_canceled'.tr(),
        align: Alignment.center,
      );
      setState(() {});
      return;
    } else {
      try {
        _isTextDetecting = true;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 60));
        RecognizeTextResponse recognizeTextResponse = await sharedOcrClient
            .use(sharedConfig.defaultOcrEngineId)
            .recognizeText(
              RecognizeTextRequest(
                imagePath: _capturedData?.imagePath,
                base64Image: _capturedData?.base64Image,
              ),
            );
        _isTextDetecting = false;
        setState(() {});
        if (sharedConfig.autoCopyDetectedText) {
          Clipboard.setData(ClipboardData(text: recognizeTextResponse.text));
        }
        _handleTextChanged(recognizeTextResponse.text, isRequery: true);
      } catch (error) {
        _isTextDetecting = false;
        setState(() {});
        BotToast.showText(
          text: error.toString(),
          align: Alignment.center,
        );
      }
    }
  }

  void _handleExtractTextFromClipboard() async {
    bool windowIsVisible = await windowManager.isVisible();
    if (!windowIsVisible) {
      await _windowShow();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    ExtractedData extractedData =
        await screenTextExtractor.extractFromClipboard();
    _handleTextChanged(extractedData.text, isRequery: true);
  }

  void _handleButtonTappedClear() {
    setState(() {
      _querySubmitted = false;
      _text = '';
      _textDetectedLanguage = null;
      _capturedData = null;
      _isTextDetecting = false;
      _extractedData = null;
      _translationResultList = [];
    });
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  void _handleButtonTappedTrans() async {
    if (_text.isEmpty) {
      BotToast.showText(
        text: 'page_home.msg_please_enter_word_or_text'.tr(),
        align: Alignment.center,
      );
      _focusNode.requestFocus();
      return;
    }
    await _queryData();
  }

  Widget _buildBannersView(BuildContext context) {
    bool isNoAllowedAllAccess =
        !(_isAllowedScreenCaptureAccess && _isAllowedScreenSelectionAccess);

    return Container(
      key: _bannersViewKey,
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: (isNoAllowedAllAccess) ? 12 : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isNoAllowedAllAccess)
            LimitedFunctionalityBanner(
              isAllowedScreenCaptureAccess: _isAllowedScreenCaptureAccess,
              isAllowedScreenSelectionAccess: _isAllowedScreenSelectionAccess,
              onTappedRecheckIsAllowedAllAccess: () async {
                _isAllowedScreenCaptureAccess =
                    await ScreenCapturer.instance.isAccessAllowed();
                _isAllowedScreenSelectionAccess =
                    await screenTextExtractor.isAccessAllowed();

                setState(() {});

                if (_isAllowedScreenCaptureAccess &&
                    _isAllowedScreenSelectionAccess) {
                  BotToast.showText(
                    text:
                        "page_home.limited_banner_msg_all_access_allowed".tr(),
                    align: Alignment.center,
                  );
                } else {
                  BotToast.showText(
                    text: "page_home.limited_banner_msg_all_access_not_allowed"
                        .tr(),
                    align: Alignment.center,
                  );
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInputView(BuildContext context) {
    return SizedBox(
      key: _inputViewKey,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TranslationInputView(
            focusNode: _focusNode,
            controller: _textEditingController,
            onChanged: (newValue) => _handleTextChanged(newValue),
            capturedData: _capturedData,
            isTextDetecting: _isTextDetecting,
            translationMode: _config.translationMode,
            onTranslationModeChanged: (newTranslationMode) {
              sharedConfigManager.setTranslationMode(newTranslationMode);
              setState(() {});
            },
            inputSetting: _config.inputSetting,
            onClickExtractTextFromScreenCapture:
                _handleExtractTextFromScreenCapture,
            onClickExtractTextFromClipboard: _handleExtractTextFromClipboard,
            onButtonTappedClear: _handleButtonTappedClear,
            onButtonTappedTrans: _handleButtonTappedTrans,
          ),
          TranslationTargetSelectView(
            translationMode: _config.translationMode,
            isShowSourceLanguageSelector: _isShowSourceLanguageSelector,
            isShowTargetLanguageSelector: _isShowTargetLanguageSelector,
            onToggleShowSourceLanguageSelector: (newValue) {
              setState(() {
                _isShowSourceLanguageSelector = newValue;
                _isShowTargetLanguageSelector = false;
              });
            },
            onToggleShowTargetLanguageSelector: (newValue) {
              setState(() {
                _isShowSourceLanguageSelector = false;
                _isShowTargetLanguageSelector = newValue;
              });
            },
            sourceLanguage: _sourceLanguage,
            targetLanguage: _targetLanguage,
            onChanged: (newSourceLanguage, newTargetLanguage) {
              setState(() {
                _isShowSourceLanguageSelector = false;
                _isShowTargetLanguageSelector = false;
                _sourceLanguage = newSourceLanguage;
                _targetLanguage = newTargetLanguage;
              });
              if (_text.isNotEmpty) {
                _handleButtonTappedTrans();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(BuildContext context) {
    return TranslationResultsView(
      viewKey: _resultsViewKey,
      controller: _scrollController,
      translationMode: _config.translationMode,
      querySubmitted: _querySubmitted,
      text: _text,
      textDetectedLanguage: _textDetectedLanguage,
      translationResultList: _translationResultList,
      onTextTapped: (word) {
        _handleTextChanged(word, isRequery: true);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildBannersView(context),
          _buildInputView(context),
          _buildResultsView(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ToolbarItemAlwaysOnTop(),
            Expanded(child: Container()),
            ToolbarItemSettings(
              onSettingsPageDismiss: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      preferredSize: const Size.fromHeight(34),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _windowResize());
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  @override
  void onProtocolUrlReceived(String url) async {
    Uri uri = Uri.parse(url);
    if (uri.scheme != 'biyiapp') return;

    if (uri.authority == 'translate') {
      if (_text.isNotEmpty) _handleButtonTappedClear();
      String? text = uri.queryParameters['text'];
      if (text != null && text.isNotEmpty) {
        _handleTextChanged(text, isRequery: true);
      }
    }
    await _windowShow();
  }

  @override
  void onShortcutKeyDownShowOrHide() async {
    bool isVisible = await windowManager.isVisible();
    if (isVisible) {
      _windowHide();
    } else {
      _windowShow();
    }
  }

  @override
  void onShortcutKeyDownHide() async {
    _windowHide();
  }

  @override
  void onShortcutKeyDownExtractFromScreenSelection() {
    _handleExtractTextFromScreenSelection();
  }

  @override
  void onShortcutKeyDownExtractFromScreenCapture() {
    _handleExtractTextFromScreenCapture();
  }

  @override
  void onShortcutKeyDownExtractFromClipboard() {
    _handleExtractTextFromClipboard();
  }

  @override
  void onShortcutKeyDownSubmitWithMateEnter() {
    if (_config.inputSetting != kInputSettingSubmitWithMetaEnter) {
      return;
    }
    _handleButtonTappedTrans();
  }

  @override
  void onTrayIconMouseDown() async {
    _windowShow(isShowBelowTray: true);
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    switch (menuItem.key) {
      case kMenuItemKeyQuickStartGuide:
        await launch('${sharedEnv.webUrl}/docs');
        break;
      case kMenuSubItemKeyJoinDiscord:
        await launch('https://discord.gg/yRF62CKza8');
        break;
      case kMenuSubItemKeyJoinQQGroup:
        await launch('https://jq.qq.com/?_wv=1027&k=vYQ5jW7y');
        break;
      case kMenuItemKeyQuitApp:
        await trayManager.destroy();
        exit(0);
        break;
    }
  }

  @override
  void onWindowFocus() async {
    _focusNode.requestFocus();
  }

  @override
  void onWindowBlur() async {
    _focusNode.unfocus();
    bool isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    if (!isAlwaysOnTop) {
      windowManager.hide();
    }
  }

  @override
  void onWindowMove() async {
    _lastShownPosition = await windowManager.getPosition();
  }
}
