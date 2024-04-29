import 'package:flutter_pokedex/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'tester/screen_tester.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('Home Screen Test', () {
    setUp(() {
      app.main();
    });

    tearDown(() async {
      final getIt = GetIt.instance;
      await getIt.reset();
    });

    testWidgets(
      'When app starts ,Then Encyclopedia Page is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 5));
        final screen = ScreenTester(tester);

        expect(await screen.isEncyclopediaPresent(), true);

        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user clicks Captured,Then Empty Widget is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = ScreenTester(tester);

        await screen.goToCapturedPage();
        expect(await screen.isEmptyWidgetPresent(), true);

        await screen.backFromCaptured();
        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user Click a Pokemon, Then DetailPage is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = ScreenTester(tester);

        await screen.clickFirstEncyclopediaPokemon();
        expect(await screen.isDetailPagePresent(), true);

        await screen.detailScrollDown();
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await screen.clickCapturePokemon();

        await screen.detailScrollUp();
        await tester.pumpAndSettle(const Duration(seconds: 2));

        await screen.backFromDetail();
        expect(await screen.isEncyclopediaPresent(), true);
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user clicks Captured, Then Captured Page is shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = ScreenTester(tester);

        await screen.goToCapturedPage();
        expect(await screen.isFavoritesPresent(), true);

        await screen.clickFirstCapturedPokemon();

        expect(await screen.isDetailPagePresent(), true);

        await screen.backFromDetail();
        expect(await screen.isFavoritesPresent(), true);

        await screen.backFromCaptured();
        expect(await screen.isEncyclopediaPresent(), true);

        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
