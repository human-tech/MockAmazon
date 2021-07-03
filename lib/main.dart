import 'package:amazon/repository/user_repository/email_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:amazon/blocs/authentication_bloc.dart';
import 'package:amazon/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:amazon/productsAPI/cache/products_cache.dart';
import 'package:amazon/productsAPI/models/product_model.dart';
import 'package:amazon/productsAPI/product_client.dart';
import 'package:amazon/productsAPI/parsers/product_parser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _products =
      await RequestProducts().executeGet<List<Product>>(const ProductParser());

  runApp(MultiProvider(providers: [
    Provider<FirebaseUserRepository>(create: (_) => FirebaseUserRepository()),
    Provider<ProductCache>(create: (_) => ProductCache(_products))
  ], child: MockAmazon()));
}

class MockAmazon extends StatelessWidget {
  const MockAmazon();

  @override
  Widget build(BuildContext context) {
    final repository =
        context.select((FirebaseUserRepository repository) => repository);

    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(repository),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const MaterialApp(
          initialRoute: RouteGenerator.initNavigator,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

abstract class AppStartup {
  static Future<List<Product>> setup() async {
    return RequestProducts().executeGet<List<Product>>(const ProductParser());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
