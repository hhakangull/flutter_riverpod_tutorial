import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = Provider<String>((ref) => 'Hello Hakan');
final titleProvider = Provider<String>((ref) => 'State Provider');
final countProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    ),
  );
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final count = ref.watch(countProvider);

    ref.listen(countProvider, ((previous, next) {
      if (next == 5) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("The Value is $next")));
      }
    }));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                // reset to provider
                //ref.invalidate(countProvider);
                // or
                ref.refresh(countProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Text(
          "$count",
          style: const TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ref.read(countProvider.notifier).state++;
          ref.read(countProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
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
