import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Combined Stream Example'),
        ),
        body: const Center(
          child: MyCombinedWidget(),
        ),
      ),
    );
  }
}

class MyCombinedWidget extends ConsumerWidget {
  const MyCombinedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combineValue = ref.watch(combinedValueNotifierProvider);

    switch (combineValue) {
      case AsyncData():
        final values = combineValue;
        return Text(
            'Stream A: ${values.value.$1}, Stream B: ${values.value.$2}');
      case AsyncLoading():
        return const CircularProgressIndicator();
      case AsyncError():
        final error = combineValue;
        return Text('Error: ${error.error}');
      default:
        return const Text('Unknown state');
    }
  }
}
