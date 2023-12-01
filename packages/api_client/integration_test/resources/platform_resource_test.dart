part of '../main.dart';

void platformResourceIntegrationTest() {
  const jiraPlatformId = 'jira';
  const githubPlatformId = 'github';
  const googleCalendarPlatformId = 'google-calendar';

  group('PlatformResource', () {
    late FirebaseFirestore firestore;
    late PlatformResource platformsApiClient;

    Future<void> setupTestDependencies(
      WidgetTester tester,
    ) async {
      final config = await tester.initFirebaseDependencies();

      firestore = config.firestore;
      platformsApiClient = PlatformResource(
        firestore: firestore,
      );
    }

    group('getPlatforms', () {
      testWidgets('streams a non empty list of platforms', (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.isNotEmpty,
              'platforms is not empty',
              isTrue,
            ),
          ),
        );
      });

      testWidgets('streams a list containing the jira platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.map((e) => e.id),
              'platforms contains jira',
              contains(jiraPlatformId),
            ),
          ),
        );
      });

      testWidgets('streams a list containing the github platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.map((e) => e.id),
              'platforms contains github',
              contains(githubPlatformId),
            ),
          ),
        );
      });

      testWidgets('streams a list containing the google-calendar platform',
          (tester) async {
        await setupTestDependencies(tester);

        final result = platformsApiClient.getPlatforms();

        expect(
          result,
          emits(
            isA<List<PlatformModel>>().having(
              (platforms) => platforms.map((e) => e.id),
              'platforms contains google-calendar',
              contains(googleCalendarPlatformId),
            ),
          ),
        );
      });
    });
  });
}
