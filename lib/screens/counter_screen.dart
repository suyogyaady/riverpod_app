import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/view_model/counter_view_model.dart';

// Creating a provider
// 1. Provider -> immutable(value cannot be changed)
final appBarTitleProvider = Provider<String>((ref) => 'My Title');

//creating a counter provider
final counterProvider = StateProvider<int>((ref) {
  return 1;
});

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(counterViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.read(appBarTitleProvider),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(counterViewModelProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 8,
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(counterViewModelProvider.notifier).decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
