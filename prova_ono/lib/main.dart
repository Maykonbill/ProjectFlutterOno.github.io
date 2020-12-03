
import 'package:flutter/material.dart';


class Sneaker {
  // Atributos
  String _nome;
  double _numero;
  double _preco;

  // Construtor
  Sneaker(this._numero, this._preco, [this._nome]);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Sneaker> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    Sneaker sneaker1 = Sneaker(41.5, 3000, "Air Dior");
    Sneaker sneaker2 = Sneaker(40.0, 1200, "Air Jordan 5");
    lista.add(sneaker1);
    lista.add(sneaker2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Sneakers",
      themeMode : ThemeMode.dark,
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Sneaker> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Sneaker> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold( 
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Sneakers (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Informações do Sneaker",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesSneaker(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text(
              "Buscar por um Sneakaer",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaBuscarPorSneaker(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              "Cadastrar um Novo Sneaker",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarSneaker(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sobre(),
                ),
              );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Sneaker
//-----------------------------------------------------------------------------

class TelaInformacoesSneaker extends StatefulWidget {
  final List<Sneaker> lista;

  // Construtor
  TelaInformacoesSneaker(this.lista);

  @override
  _TelaInformacoesSneaker createState() => _TelaInformacoesSneaker(lista);
}

class _TelaInformacoesSneaker extends State<TelaInformacoesSneaker> {
  // Atributos
  final List lista;
  Sneaker sneaker;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final precoController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesSneaker(this.lista) {
    if (lista.length > 0) {
      index = 0;
      sneaker = lista[0];
      nomeController.text = sneaker._nome;
      numeroController.text = sneaker._numero.toString();
      precoController.text = sneaker._preco.toString();
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      sneaker = lista[index];
      nomeController.text = sneaker._nome;
      numeroController.text = sneaker._numero.toString();
      precoController.text = sneaker._preco.toString();
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._numero = double.parse(numeroController.text);
      lista[index]._preco = double.parse(precoController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Sneaker";
    if (sneaker == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum sneaker encontrado!"),
            Container(
              color: Colors.black,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Editar"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
          
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Numero",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: numeroController,
              ),
            ),
           
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Preco",
                  hintText: "Preco",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: precoController,
              ),
            ),
            
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Buscar por Sneaker
// ----------------------------------------------------------------------------

class TelaBuscarPorSneaker extends StatefulWidget {
  @override
  _TelaBuscarPorSneaker createState() => _TelaBuscarPorSneaker();
}

class _TelaBuscarPorSneaker extends State<TelaBuscarPorSneaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar por Sneaker")),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Cadastrar Sneaker
// ----------------------------------------------------------------------------

class TelaCadastrarSneaker extends StatefulWidget {
  final List<Sneaker> lista;

  // Construtor
  TelaCadastrarSneaker(this.lista);

  @override
  _TelaCadastrarSneakerState createState() =>
      _TelaCadastrarSneakerState(lista);
}

class _TelaCadastrarSneakerState extends State<TelaCadastrarSneaker> {
  // Atributos
  final List<Sneaker> lista;
  String _nome = "";
  double _numero = 0.0;
  double _preco = 0.0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final numeroController = TextEditingController();
  final precoController = TextEditingController();

  // Construtor
  _TelaCadastrarSneakerState(this.lista);

  // Métodos
  void _cadastrarSneaker() {
    _nome = nomeController.text;
    _numero = double.parse(numeroController.text);
    _preco = double.parse(precoController.text);
    if (_numero > 0 && _preco > 0) {
      var sneaker = Sneaker(_numero, _preco, _nome); // Cria um novo objeto
     
      lista.add(sneaker);
      
      nomeController.text = "";
      numeroController.text = "";
      precoController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Sneaker"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Sneaker:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            // --- Nome do Snekar ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do sneaker",
                  // hintText: "Nome do Sneaker",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --Numero Sneaker ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Numero ",
                  // hintText: 'Numero do Snekaer (kg)',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: numeroController,
              ),
            ),
            // --- Preco do Sneaker ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Preço ",
                  hintText: "Preço",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: precoController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Cadastrar Sneaker",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarSneaker,
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Sobre
// ----------------------------------------------------------------------------

class Sobre extends StatefulWidget  {
  SobreContext createState() => SobreContext();
}
class SobreContext extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    var titulo = "Sobre";

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Column(
        children: <Widget>[
          Text("Maykon Bill Carvalho de Jesus - RA 180002114", 
          style: TextStyle(fontSize: 20.0),),
          Container(height: 20, width: 20),
          Text("Aplicação feita para cadstrar seus sneakers", 
          style: TextStyle(fontSize: 20.0),),
          Container(height: 20, width: 20),
          Text("Versão 1.0", 
          style: TextStyle(fontSize: 25.0),),
        ],
      ),
    );
  }
}
