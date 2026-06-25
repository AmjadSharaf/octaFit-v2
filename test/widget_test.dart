import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:octafit/app.dart';

void main() {
  testWidgets('OctaFit app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [],
        child: OctaFitApp(),
      ),
    );
    await tester.pump();
    expect(find.byType(OctaFitApp), findsOneWidget);
  });
}
