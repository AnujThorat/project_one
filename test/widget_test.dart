// test/widget_test.dart
// Basic smoke test for CampusConnectApp

import 'package:flutter_test/flutter_test.dart';
import 'package:project_one/main.dart';

void main() {
  testWidgets('CampusConnect smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CampusConnectApp());

    // Verify that splash screen branding is shown.
    expect(find.text('CampusConnect'), findsOneWidget);
    expect(find.text('Riverside College'), findsOneWidget);
  });
}
