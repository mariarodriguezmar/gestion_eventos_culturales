void mostrarBienvenida() {
  print('SISTEMA DE GESTIÓN DE EVENTOS CULTURALES');
  print('Bienvenido');
}

class Evento {
  // Atributos: info que tendrá cada evento.
  int codigo;
  String nombre;
  String categoria;
  String lugar;
  DateTime fecha;
  int capacidad;

  // Constructor:  datos del evento.
  Evento({
    required this.codigo,
    required this.nombre,
    required this.categoria,
    required this.lugar,
    required this.fecha,
    required this.capacidad,
  });

  // Metodo: muestra la info del evento.
  void mostrarInformacion() {
    print('Código: $codigo');
    print('Nombre: $nombre');
    print('Categoría: $categoria');
    print('Lugar: $lugar');
    print('Fecha: $fecha');
    print('Capacidad: $capacidad personas');
  }
}