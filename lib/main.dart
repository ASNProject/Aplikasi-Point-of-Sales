import 'package:cash_whiz/core/models/hive/product_model.dart';
import 'package:cash_whiz/core/models/hive/sale_model.dart';
import 'package:cash_whiz/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox('data_box');
  Hive.registerAdapter(SaleModelAdapter());
  await Hive.openBox('data_history');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.returnRouter(),
    );
  }
}
