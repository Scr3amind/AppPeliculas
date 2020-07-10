import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  final peliculas = [
    'Spiderman',
    'Justice League',
    'Parasite',
    'Scooby doo'
  ];

  final peliculasRecientes = [
    'Scooby Doo',
    'Wonder Woman 1984',
    'Mulan'
    'Super Man'

  ];



  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de Appbar
    return[
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
         query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono izquierda de appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ),
      onPressed: () {
        close(
          context, 
          null
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se mostraran
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al escribir

    final listaSugerida = (query.isEmpty) 
                          ? peliculasRecientes
                          : peliculas.where(
                            (element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
        );
      },
    );
  }

}