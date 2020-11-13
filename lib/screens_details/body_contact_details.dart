import 'package:flutter/material.dart';

import '../constants.dart';
import 'title_address_name.dart';
import 'backdrop_rating.dart';
import 'genres.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyContactDetails extends StatelessWidget {
  BodyContactDetails({Key key, @required this.contact}) : super(key: key);
  final Map<String, dynamic> contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(contact: contact),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launchZap(contact['telefone1']);
        },
        label: Text('Zap'),
        icon: Icon(Icons.call),
      ),
    );
  }

  void launchZap(urlString) async {
    var whatsappUrl = "whatsapp://send?phone=$urlString";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}

class Body extends StatelessWidget {
  final Map<String, dynamic> contact;

  const Body({Key key, this.contact}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it will provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackdropAndRating(
            size: size,
            image: contact['imagem'],
          ),
          SizedBox(height: kDefaultPadding / 2),
          TitleAdressName(
            name: contact['nome'],
            city: contact['endereco']['cidade'],
            neighbourhood: contact['endereco']['bairro'],
            uf: contact['endereco']['UF'],
          ),
          ServiceTypes(servicos: contact['servicos']),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              "Sobre",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              contact['descricao'] == null ? '' : contact['descricao'],
              style: TextStyle(
                color: kTextLightColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}