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

// Funcion busqueda de eventos por diferentes criterios.
void buscarEvento() {
  print('\nBUSCAR EVENTO');

  if (eventos.isEmpty) {
    print('Aún no hay eventos registrados.');
    return;
  }

  print('1. Filtrar por código');
  print('2. Filtrar por nombre');
  print('3. Filtrar por fecha');
  print('4. Filtrar por categoría');
  print('5. Filtrar por lugar');

  stdout.write('Elige el tipo de búsqueda: ');
  String opcion = stdin.readLineSync() ?? '';

  switch (opcion) {
    case '1':
      stdout.write('Ingresa el código del evento: ');
      int? codigoBuscado =
          int.tryParse(stdin.readLineSync() ?? '');

      if (codigoBuscado == null) {
        print('Error: ingresa un código numérico.');
        break;
      }

      bool encontradoPorCodigo = false;

      for (Evento eventoActual in eventos) {
        if (eventoActual.codigo == codigoBuscado) {
          eventoActual.mostrarInformacion();
          encontradoPorCodigo = true;
          break;
        }
      }

      if (!encontradoPorCodigo) {
        print('No se encontró un evento con ese código.');
      }
      break;

    case '2':
      stdout.write('Ingresa el nombre del evento: ');
      String nombreBuscado =
          (stdin.readLineSync() ?? '').trim().toLowerCase();

      if (nombreBuscado.isEmpty) {
        print('Error: debes ingresar un nombre.');
        break;
      }

      bool encontradoPorNombre = false;

      for (Evento eventoActual in eventos) {
        if (eventoActual.nombre
            .toLowerCase()
            .contains(nombreBuscado)) {
          eventoActual.mostrarInformacion();
          encontradoPorNombre = true;
        }
      }

      if (!encontradoPorNombre) {
        print('No se encontraron eventos con ese nombre.');
      }
      break;

    case '3':
      stdout.write('Ingresa la fecha (AAAA-MM-DD): ');
      String fechaTexto = stdin.readLineSync() ?? '';
      DateTime? fechaBuscada = DateTime.tryParse(fechaTexto);

      if (fechaBuscada == null ||
          !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(fechaTexto)) {
        print('Error: ingresa una fecha válida en formato AAAA-MM-DD.');
        break;
      }

      bool encontradoPorFecha = false;

      for (Evento eventoActual in eventos) {
        if (eventoActual.fecha.year == fechaBuscada.year &&
            eventoActual.fecha.month == fechaBuscada.month &&
            eventoActual.fecha.day == fechaBuscada.day) {
          eventoActual.mostrarInformacion();
          encontradoPorFecha = true;
        }
      }

      if (!encontradoPorFecha) {
        print('No se encontraron eventos para esa fecha.');
      }
      break;


    case '4':
      stdout.write('Ingresa la categoría: ');
      String categoriaBuscada =
          (stdin.readLineSync() ?? '').trim().toLowerCase();

      if (categoriaBuscada.isEmpty) {
        print('Error: debes ingresar una categoría.');
        break;
      }

      bool encontradoPorCategoria = false;

      for (Evento eventoActual in eventos) {
        if (eventoActual.categoria
            .toLowerCase()
            .contains(categoriaBuscada)) {
          eventoActual.mostrarInformacion();
          encontradoPorCategoria = true;
        }
      }

      if (!encontradoPorCategoria) {
        print('No se encontraron eventos de esa categoría.');
      }
      break;

    case '5':
      stdout.write('Ingresa el lugar: ');
      String lugarBuscado =
          (stdin.readLineSync() ?? '').trim().toLowerCase();

      if (lugarBuscado.isEmpty) {
        print('Error: debe ingresar un lugar.');
        break;
      }

      bool encontradoPorLugar = false;

      for (Evento eventoActual in eventos) {
        if (eventoActual.lugar
            .toLowerCase()
            .contains(lugarBuscado)) {
          eventoActual.mostrarInformacion();
          encontradoPorLugar = true;
        }
      }

      if (!encontradoPorLugar) {
        print('No se encontraron eventos en ese lugar.');
      }
      break;

    default:
      print('Opción no válida. Elige una opción válida.');
  }
}


void modificarEvento() {
  print('\nMODIFICAR EVENTO');

  if (eventos.isEmpty) {
    print('No hay eventos registrados para modificar.');
    return;
  }

  stdout.write('Ingresa el código del evento que deseas modificar: ');
  int? codigoBuscado = int.tryParse(stdin.readLineSync() ?? '');

  if (codigoBuscado == null) {
    print('Error: debes ingresar un código numérico.');
    return;
  }

  Evento? eventoEncontrado;

  for (Evento eventoActual in eventos) {
    if (eventoActual.codigo == codigoBuscado) {
      eventoEncontrado = eventoActual;
      break;
    }
  }

  if (eventoEncontrado == null) {
    print('No se encontró un evento con ese código.');
    return;
  }

  print('\nDatos actuales del evento:');
  eventoEncontrado.mostrarInformacion();

  print('\nIngresa los nuevos datos del evento.');

  stdout.write('Nuevo nombre: ');
  String nombreNuevo = stdin.readLineSync() ?? '';

  stdout.write('Nueva categoría: ');
  String categoriaNueva = stdin.readLineSync() ?? '';

  stdout.write('Nuevo lugar: ');
  String lugarNuevo = stdin.readLineSync() ?? '';

  stdout.write('Nueva fecha (AAAA-MM-DD): ');
  String fechaTexto = stdin.readLineSync() ?? '';

  stdout.write('Nueva hora (HH:MM): ');
  String horaTexto = stdin.readLineSync() ?? '';

  stdout.write('Nueva capacidad: ');
  String capacidadTexto = stdin.readLineSync() ?? '';

  bool datosValidos = true;

  if (nombreNuevo.trim().isEmpty) {
    print('Error: el nombre es obligatorio.');
    datosValidos = false;
  }

  if (categoriaNueva.trim().isEmpty) {
    print('Error: la categoría es obligatoria.');
    datosValidos = false;
  }

  if (lugarNuevo.trim().isEmpty) {
    print('Error: el lugar es obligatorio.');
    datosValidos = false;
  }

  
DateTime? fechaNueva;

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

  fechaNueva = DateTime(
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


  int? capacidadNueva = int.tryParse(capacidadTexto);

  if (capacidadNueva == null || capacidadNueva <= 0) {
    print('Error: la capacidad debe ser un entero mayor que cero.');
    datosValidos = false;
  }

  if (!datosValidos) {
    print('No se modificó el evento. Revisa los datos e inténtalo de nuevo.');
    return;
  }

  eventoEncontrado.nombre = nombreNuevo.trim();
  eventoEncontrado.categoria = categoriaNueva.trim();
  eventoEncontrado.lugar = lugarNuevo.trim();
  eventoEncontrado.fecha = fechaNueva!;
  eventoEncontrado.capacidad = capacidadNueva!;

  print('\n¡Evento modificado correctamente!');
  eventoEncontrado.mostrarInformacion();
}
