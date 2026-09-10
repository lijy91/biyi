import 'package:beyondtranslate_ui/beyondtranslate_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../host.dart';

void main() {
  testWidgets('the panel is as wide as its rows, not as wide as the window', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        Center(
          child: Menu(
            items: const [
              MenuItem(label: 'Open'),
              MenuItem(label: 'Rename'),
              MenuItem(label: 'Duplicate'),
            ],
            trigger: (context, state) =>
                Button(onPressed: state.toggle, child: const Text('Actions')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Actions'));
    await tester.pump();

    final double window =
        tester.view.physicalSize.width / tester.view.devicePixelRatio;
    final double panel = tester.getSize(find.byType(MenuPanel)).width;
    final ThemeVariables vars = ThemeData.light().vars;

    // Shrink-to-fit with a floor, the way `popup.css` has it: `min-width` and
    // nothing else. A panel that filled the overlay would be the whole window
    // wide on a three-row menu.
    expect(panel, vars.menuMinWidth);
    expect(panel, lessThan(window));

    // Narrowing the panel must not move it: `MenuAlign.end` lines its trailing
    // edge up with the trigger's, and the align inside the follower is what
    // does that whatever the panel measures.
    expect(
      tester.getBottomRight(find.byType(MenuPanel)).dx,
      moreOrLessEquals(
        tester.getBottomRight(find.byType(Button)).dx,
        epsilon: 0.5,
      ),
    );
  });

  testWidgets('a long label widens the panel rather than being clipped', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        Center(
          child: Menu(
            items: const [
              MenuItem(label: 'Reveal the generated tokens in the Finder'),
            ],
            trigger: (context, state) =>
                Button(onPressed: state.toggle, child: const Text('Actions')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Actions'));
    await tester.pump();

    final ThemeVariables vars = ThemeData.light().vars;
    expect(
      tester.getSize(find.byType(MenuPanel)).width,
      greaterThan(vars.menuMinWidth),
    );
  });

  testWidgets('a combobox list is at least as wide as the field it dropped '
      'from', (tester) async {
    await tester.pumpWidget(
      host(
        Center(
          child: SizedBox(
            width: 320,
            child: Combobox<String>(
              options: const [
                ComboboxOption(value: 'utc', label: 'UTC'),
                ComboboxOption(value: 'cet', label: 'CET'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Combobox<String>));
    await tester.pump();

    // The stylesheet's `min-width: var(--anchor-width)`: a list narrower than
    // the field it dropped out of reads as a different control.
    expect(tester.getSize(find.byType(MenuPanel)).width, 320);
  });

  testWidgets(
    'a popover is as wide as its content, not as wide as the window',
    (tester) async {
      await tester.pumpWidget(
        host(
          Center(
            child: Popover(
              title: const Text('Build 4.2.1'),
              trigger: (context, state) =>
                  Button(onPressed: state.toggle, child: const Text('About')),
            ),
          ),
        ),
      );

      await tester.tap(find.text('About'));
      await tester.pump();

      final double window =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;
      expect(
        tester.getSize(find.byType(PopoverPanel)).width,
        lessThan(window / 2),
      );
    },
  );
}
