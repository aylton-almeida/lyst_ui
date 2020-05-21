import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/categories/editCategory.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';
import 'package:lystui/utils/string.extension.dart';

class AboutScreen extends StatefulWidget {
  static final String routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();


  void _onBackPressed() {
  }
    @override
    Widget build(BuildContext context) {
        return Scaffold(

            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _onBackPressed,
              ),
              title: Text('About'),
            ),

            body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
              //Image.asset('lib/assets/PP.png', width: 300, height: 250,),
              const SizedBox(height: 20),
              Text(
                'Esse projeto foi desenvolvido por aluno do curso de Engenharia de Software pela             PUC-Minas. Conheça a equipe: ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
               SizedBox(height: 20,
                width : 15 ),

              ListTile(
                title: Text('Amanda Lima',style: TextStyle( fontSize: 20)),
                subtitle: Text('Desenvolvedora',style: TextStyle(fontSize: 13)),
                leading: SizedBox(height: 20,
                width: 100.0, // fixed width and height
        //        child:  Image.asset('lib/assets/amanda.png'),
                ),
              ),
        ListTile(
            title: Text('Aylton Almeida',style: TextStyle( fontSize: 20)),
            subtitle: Text('Desenvolvedor',style: TextStyle(fontSize: 13)),
          leading: SizedBox(height: 20,
            width: 100.0, // fixed width and height
      //      child:  Image.asset('lib/assets/aylton.png'),
        ),),
      ListTile(
      title: Text('Lucas Lima',style: TextStyle( fontSize: 20)),
      subtitle: Text('Desenvolvedor',style: TextStyle(fontSize: 13)),
        leading: SizedBox(height: 20,
      width: 100.0, // fixed width and height
      //child:  Image.asset('lib/assets/lucas.png'),
      ),),
      ListTile(
      title: Text('Lucca Romaniello',style: TextStyle( fontSize: 20)),
      subtitle: Text('Desenvolvedor',style: TextStyle(fontSize: 13)),
        leading: SizedBox(height: 20,
      width: 100.0, // fixed width and height
    //  child:  Image.asset('lib/assets/lucca.png'),
        ), ),
      ],
            ),
      ),
      ),
      );
    }
}
