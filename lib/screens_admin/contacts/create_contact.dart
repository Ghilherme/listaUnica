import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listaUnica/apis/models/contacts.dart';
import 'package:listaUnica/apis/models/states.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants.dart';

class CreateContact extends StatelessWidget {
  final ContactsModel contact;

  const CreateContact({Key key, this.contact}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Criar Contato'),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: CreateContactBody(contact),
    );
  }
}

class CreateContactBody extends StatefulWidget {
  CreateContactBody(this.contact);
  final ContactsModel contact;

  @override
  _CreateContactBodyState createState() =>
      _CreateContactBodyState(this.contact);
}

class _CreateContactBodyState extends State<CreateContactBody> {
  _CreateContactBodyState(this.contact);
  final ContactsModel contact;
  States _dropdownValue = statesList[24]; //SAO PAULO

  final _form = GlobalKey<FormState>();
  ContactsModel _contactModel;

  initState() {
    super.initState();
    getServiceTypes();

    _contactModel = ContactsModel.fromContact(contact);
    if (_contactModel.address.state.isNotEmpty) {
      _dropdownValue = statesList
          .where((element) => element.state == _contactModel.address.state)
          .first;
      _contactModel.address.uf = _dropdownValue.uf;
      _contactModel.address.state = _dropdownValue.state;
    }
  }

  List<MultiSelectItem> _items = List<MultiSelectItem>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.name,
                onChanged: (value) {
                  _contactModel.name = value;
                },
                decoration: InputDecoration(
                  hintText: "Nome",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: new TextFormField(
                initialValue: _contactModel.email,
                onChanged: (value) {
                  _contactModel.email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: new TextFormField(
                initialValue: _contactModel.description,
                onChanged: (value) {
                  _contactModel.description = value;
                },
                maxLines: 3,
                decoration: new InputDecoration(
                  hintText: "Descrição",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: MultiSelectDialogField(
                  initialValue: _contactModel.serviceType,
                  items: _items,
                  title: Text('Prestadores'),
                  buttonText: Text('Prestadores',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  onConfirm: (results) => _contactModel.serviceType = results,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: new TextFormField(
                initialValue: _contactModel.site,
                onChanged: (value) {
                  _contactModel.site = value;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Site",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: TextFormField(
                initialValue: _contactModel.telNumbers['whatsapp'],
                onChanged: (value) {
                  _contactModel.telNumbers = {'whatsapp': value};
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Telefone",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
            Divider(),
            Text(
              'Endereço',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              textAlign: TextAlign.right,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.address.strAvnName,
                onChanged: (value) {
                  _contactModel.address.strAvnName = value;
                },
                decoration: InputDecoration(
                  hintText: "Rua/Avenida",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.address.compliment,
                onChanged: (value) {
                  _contactModel.address.compliment = value;
                },
                decoration: InputDecoration(
                  hintText: "Complemento",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.address.number,
                onChanged: (value) {
                  _contactModel.address.number = value;
                },
                decoration: InputDecoration(
                  hintText: "Número",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.address.neighborhood,
                onChanged: (value) {
                  _contactModel.address.neighborhood = value;
                },
                decoration: InputDecoration(
                  hintText: "Bairro",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                initialValue: _contactModel.address.city,
                onChanged: (value) {
                  _contactModel.address.city = value;
                },
                decoration: InputDecoration(
                  hintText: "Cidade",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Campo obrigatório' : null,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: DropdownButton<States>(
                isExpanded: true,
                hint: Text('Estado'),
                value: _dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (States newValue) {
                  _contactModel.address.uf = newValue.uf;
                  _contactModel.address.state = newValue.state;
                  setState(() {
                    _dropdownValue = newValue;
                  });
                },
                items: statesList.map<DropdownMenuItem<States>>((States value) {
                  return DropdownMenuItem<States>(
                    value: value,
                    child: Text(value.state),
                  );
                }).toList(),
              ),
            ),
            Container(height: 30),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                child: Text('Salvar'),
                onPressed: addContact,
              ),
            ),
            Container(height: 30),
          ],
        ),
      ),
    );
  }

  void addContact() {
    if (_form.currentState.validate()) {
      DocumentReference contactDB = FirebaseFirestore.instance
          .collection('contatos')
          .doc(_contactModel.id);
      contactDB
          .set({
            'nome': _contactModel.name,
            'email': _contactModel.email,
            'descricao': _contactModel.description,
            'servicos': _contactModel.serviceType,
            'site': _contactModel.site,
            'telefone1': _contactModel.telNumbers,
            'endereco': {
              'endereco': _contactModel.address.strAvnName,
              'complemento': _contactModel.address.compliment,
              'numero': _contactModel.address.number,
              'bairro': _contactModel.address.neighborhood,
              'cidade': _contactModel.address.city,
              'estado': _contactModel.address.state,
              'UF': _contactModel.address.uf,
            },
          })
          .then((value) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: _contactModel.id == null
                        ? Text('Contato adicionado com sucesso.')
                        : Text('Contato atualizado com sucesso.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ))
          .catchError((error) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: _contactModel.id == null
                        ? Text('Falha ao adicionar o contato.')
                        : Text('Falha ao atualizar o contato.'),
                    content: Text('Erro: ' + error),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ));
    }
  }

  Future<void> getServiceTypes() async {
    //Pega a tabela categorias somente da categoria selecionada
    List<String> prestadores = new List<String>();
    await FirebaseFirestore.instance
        .collection('prestadores')
        .orderBy('nome')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        return prestadores.add(element.data()['nome']);
      });
    });
    setState(() {
      _items = prestadores
          .map((prestador) => MultiSelectItem<String>(prestador, prestador))
          .toList();
    });
  }
}