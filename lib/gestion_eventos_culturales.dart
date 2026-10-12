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
    print('Fecha: ${fecha.day}/${fecha.month}/${fecha.year}');
    print('Hora: ${fecha.hour}:${fecha.minute.toString()}');  
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

  stdout.write('Hora (HH:MM, formato 24 horas): ');
  String horaTexto = stdin.readLineSync() ?? '';

  stdout.write('Capacidad: ');
  String capacidadTexto = stdin.readLineSync() ?? '';

  bool datosValidos = true;

  if (nombre.trim().isEmpty) {
    print('Error: el nombre es obligatorio.');
    datosValidos = false;
  }

  if (categoria.trim().isEmpty) {
    print('Error: la categoría es obligatoria.');
    datosValidos = false;
  }

  if (lugar.trim().isEmpty) {
    print('Error: el lugar es obligatorio.');
    datosValidos = false;
  }

 
DateTime? fecha;

try {

  DateTime fechaIngresada = DateTime.parse(fechaTexto);

  List<String> partesHora = horaTexto.split(':');

  if (partesHora.length != 2) {
    throw FormatException('Formato de hora incorrecto');
  }

  int? hora = int.tryParse(partesHora[0]);
  int? minuto = int.tryParse(partesHora[1]);

  if (hora == null ||
      minuto == null ||
      hora < 0 ||
      hora > 23 ||
      minuto < 0 ||
      minuto > 59) {
    throw FormatException('Hora no válida');
  }

  fecha = DateTime(
    fechaIngresada.year,
    fechaIngresada.month,
    fechaIngresada.day,
    hora,
    minuto,
  );
} catch (e) {
  print('Error: revisa que la fecha y la hora sean válidas.');
  datosValidos = false;
}


  int? capacidad = int.tryParse(capacidadTexto);

  if (capacidad == null || capacidad <= 0) {
    print('Error: la capacidad debe ser un entero mayor que cero.');
    datosValidos = false;
  }

  if (!datosValidos) {
    print('No se registró el evento. Corrige los datos e inténtalo de nuevo.');
    return;
  }

  Evento nuevoEvento = Evento(
    codigo: siguienteCodigo,
    nombre: nombre.trim(),
    categoria: categoria.trim(),
    lugar: lugar.trim(),
    fecha: fecha!,
    capacidad: capacidad!,
  );

  eventos.add(nuevoEvento);
  siguienteCodigo++;

  print('¡Evento registrado correctamente!');
  print('Código asignado: ${nuevoEvento.codigo}');
  nuevoEvento.mostrarInformacion();
}

void listarEventos() {
  print('\nLISTA DE EVENTOS');

  if (eventos.isEmpty) {
    print('No hay eventos registrados.');
    return;
  }

  for (Evento eventoActual in eventos) {
    eventoActual.mostrarInformacion();
  }
}
