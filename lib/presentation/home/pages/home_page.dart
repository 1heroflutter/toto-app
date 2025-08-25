import 'package:flutter/material.dart';
import 'package:mytodoapp/common/widgets/appbar/basic_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: BasicAppBar(
          icon: Icons.sort,
          title: Text(
            'Index',
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
          onLeadingTap: (){},
          suffer: null,
        ),
      ),
      body: Column(children: [

      ]),
    );
  }
}
