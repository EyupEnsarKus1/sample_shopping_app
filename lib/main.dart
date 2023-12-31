import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_shopping_app/service/hive_service.dart';
import 'package:sample_shopping_app/shopping_list_page.dart';

import 'bloc/shop_bloc.dart';
import 'bloc/shop_event.dart';
import 'model/shopping_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ShopModelAdapter());

  HiveService<ShopModel> hiveService = HiveService<ShopModel>(boxName: 'shop_box');
  await hiveService.init();

  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService<ShopModel> hiveService;

  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<ShopBloc>(
        create: (context) {
          final bloc = ShopBloc(hiveService);
          bloc.add(LoadItems());
          return bloc;
        },
        child: ShopListPage(),
      ),
    );
  }
}
