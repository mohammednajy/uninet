import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/localServices/sherd_perf_manager.dart';
import 'uninet.dart';



class AppStartUp extends ConsumerWidget {
  const AppStartUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupAsyncValue = ref.watch(appStartupProvider);

    return appStartupAsyncValue.when(
      data: (_) {
        return const UniNet();
      },
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $err'),
              ElevatedButton(
                  onPressed: () {
                    ref.invalidate(appStartupProvider);
                  },
                  child: const Text('retrty'))
            ],
          ),
        ),
      ),
    );
  }
}



final appStartupProvider = FutureProvider<void>((ref) async {
  // Setup disposal logic
  ref.onDispose(() {
    // Ensure dependent providers are disposed as well
    ref.invalidate(sharedPreferencesProvider);
  });

  // Await for all initialization code to be complete before returning
  await ref.watch(sharedPreferencesProvider.future);
});


