  import 'package:flutter/material.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contador con historial',
        home: MyHomePage(title: 'Contador con Historial'),
      );
    }
  }

  class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    int _counter = 0;

    // Variables
    List<int> _historial = [];
    bool _mostrarHistorial = false;

    //Guardar valores en historial
    void _incrementCounter() {
      setState(() {
        _counter++;
        _historial.add(_counter);
      });
    }

    void _decrementCounter() {
      setState(() {
        _counter--;
        _historial.add(_counter);
      });
    }

    void _toggleHistorial() {
      setState(() {
        _mostrarHistorial = !_mostrarHistorial;
      });
    }

    void _limpiarHistorial() {
      setState(() {
        _historial.clear();
      });
    }

    // historial
    Widget _buildHistorial() {
      if (!_mostrarHistorial) return const SizedBox.shrink();

      if (_historial.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "No hay historial todavía.",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        );
      }

      return SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: _historial.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.history),
              title: Text("Valor: ${_historial[index]}"),
            );
          },
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            // mostrar/ocultar
            IconButton(
              onPressed: _toggleHistorial,
              icon: Icon(
                _mostrarHistorial ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            // Botón limpiar
            IconButton(
              onPressed: _limpiarHistorial,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Valor del contador:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              _buildHistorial(),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: _decrementCounter,
              tooltip: 'Restar',
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: _incrementCounter,
              tooltip: 'Sumar',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      );
    }
  }
