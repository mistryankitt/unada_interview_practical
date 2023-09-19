import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:unada_interview/screens/home/provider.dart';

class MultiProviderApp extends StatelessWidget {
  final Widget child;

  const MultiProviderApp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
            create: (BuildContext context) => HomeProvider()),
      ],
      child: child,
    );
  }
}
