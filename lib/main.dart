import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_application/grocery_app.dart';
import 'package:grocery_application/main.config.dart';
import 'package:grocery_application/presentation/bloc_observer.dart';
import 'package:grocery_application/utils/database/isar_db.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await configureDependencies();
  await openIsar();
  runApp(const GroceryApp());
}

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async => getIt.init();
