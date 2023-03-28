import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = Provider<String>((ref) => 'Hello Hakan');
final titleProvider = Provider<String>((ref) => 'RiverPod Examples');

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

class Main extends ConsumerStatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  ConsumerState<Main> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  @override
  void initState() {
    super.initState();
    final name = ref.read(nameProvider);
    print("initState => $name");
  }

  @override
  Widget build(BuildContext context) {
    var name = ref.watch(nameProvider);
    var title = ref.watch(titleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 46),
            ),
          )
        ],
      ),
    );
  }
}

class HomeRiverPod extends ConsumerWidget {
  const HomeRiverPod({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.read(titleProvider);
    final name = ref.read(nameProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 20),
            Consumer(
                builder: (context, ref, child) => Text(ref.read(nameProvider))),
            Text(
              '0',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
