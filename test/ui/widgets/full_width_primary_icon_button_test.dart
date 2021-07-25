import 'package:app/ui/widgets/full_width_primary_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../extensions/widget_tester_extension.dart';

void main() {
  Widget mount({void Function()? onPressed}) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        FullWidthPrimaryIconButton(
          icon: CupertinoIcons.phone,
          label: 'Call Me',
          onPressed: onPressed,
        ),
      ],
    );
  }

  testWidgets('renders', (WidgetTester tester) async {
    await tester.pumpKoelWidget(mount());

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.text('Call Me'), findsOneWidget);

    await expectLater(
      find.byType(FullWidthPrimaryIconButton),
      matchesGoldenFile(
        'goldens/full_width_primary_icon_button.png',
      ),
    );
  });

  testWidgets('triggers callback', (WidgetTester tester) async {
    var onPressed = MockOnPress();
    await tester.pumpKoelWidget(mount(onPressed: onPressed));

    await tester.tap(find.byType(ElevatedButton));
    expect(onPressed.called, isTrue);
  });
}

class MockOnPress {
  bool called = false;
  call() => called = true;
}
