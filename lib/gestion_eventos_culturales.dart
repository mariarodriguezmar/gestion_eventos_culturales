import 'dart:io';

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

List<Evento> eventos = [];

int siguienteCodigo = 1;

void registrarEvento() {
  print('\n REGISTRAR EVENTO');

  stdout.write('Nombre del evento: ');
  String nombre = stdin.readLineSync() ?? '';

  stdout.write('Categoría: ');
  String categoria = stdin.readLineSync() ?? '';

  stdout.write('Lugar: ');
  String lugar = stdin.readLineSync() ?? '';

  stdout.write('Fecha (AAAA-MM-DD): ');
  String fechaTexto = stdin.readLineSync() ?? '';

  stdout.write('Capacidad: ');
  String capacidadTexto = stdin.readLineSync() ?? '';

  DateTime? fecha;
  try {
    fecha = DateTime.parse(fechaTexto);
  } catch (e) {
    print('Error: la fecha no tiene un formato válido.');
    return;
  }

  int? capacidad = int.tryParse(capacidadTexto);

  if (nombre.trim().isEmpty ||
      categoria.trim().isEmpty ||
      lugar.trim().isEmpty) {
    print('Error: nombre, categoría y lugar son obligatorios.');
    return;
  }

  if (capacidad == null || capacidad <= 0) {
    print('Error: la capacidad debe ser un entero mayor que cero.');
    return;
  }

  Evento nuevoEvento = Evento(
    codigo: siguienteCodigo,
    nombre: nombre.trim(),
    categoria: categoria.trim(),
    lugar: lugar.trim(),
    fecha: fecha,
    capacidad: capacidad,
  );

  eventos.add(nuevoEvento);
  siguienteCodigo++;

  print('¡Evento registrado correctamente!');
  print('Código asignado: ${nuevoEvento.codigo}');
}
