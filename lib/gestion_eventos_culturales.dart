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

  print('\n¿Qué campos deseas modificar?');
  print('Escribe los números separados por comas.');
  print('1. Nombre');
  print('2. Categoría');
  print('3. Lugar');
  print('4. Fecha');
  print('5. Hora');
  print('6. Capacidad');

  stdout.write('Selecciona los campos: ');
  String seleccion = stdin.readLineSync() ?? '';

  List<String> camposSeleccionados = seleccion
      .split(',')
      .map((campo) => campo.trim())
      .toList();

  Set<String> opcionesValidas = {'1', '2', '3', '4', '5', '6'};

  bool seleccionValida =
      camposSeleccionados.isNotEmpty &&
      camposSeleccionados.every(
        (campo) => opcionesValidas.contains(campo),
      ) &&
      camposSeleccionados.toSet().length == camposSeleccionados.length;

  if (!seleccionValida) {
    print('Selección inválida. Revisa los números e inténtalo de nuevo.');
    return;
  }

  String nombreNuevo = eventoEncontrado.nombre;
  String categoriaNueva = eventoEncontrado.categoria;
  String lugarNuevo = eventoEncontrado.lugar;
  DateTime fechaNueva = eventoEncontrado.fecha;
  int capacidadNueva = eventoEncontrado.capacidad;

  bool datosValidos = true;

  for (String campo in camposSeleccionados) {
    switch (campo) {
      case '1':
        stdout.write('Nuevo nombre: ');
        String entrada = stdin.readLineSync() ?? '';

        if (entrada.trim().isEmpty) {
          print('Error: el nombre es obligatorio.');
          datosValidos = false;
        } else {
          nombreNuevo = entrada.trim();
        }
        break;

      case '2':
        stdout.write('Nueva categoría: ');
        String entrada = stdin.readLineSync() ?? '';

        if (entrada.trim().isEmpty) {
          print('Error: la categoría es obligatoria.');
          datosValidos = false;
        } else {
          categoriaNueva = entrada.trim();
        }
        break;

      case '3':
        stdout.write('Nuevo lugar: ');
        String entrada = stdin.readLineSync() ?? '';

        if (entrada.trim().isEmpty) {
          print('Error: el lugar es obligatorio.');
          datosValidos = false;
        } else {
          lugarNuevo = entrada.trim();
        }
        break;

      case '4':
        stdout.write('Nueva fecha (AAAA-MM-DD): ');
        String fechaTexto = stdin.readLineSync() ?? '';

        DateTime? fechaIngresada = DateTime.tryParse(fechaTexto);

        if (fechaIngresada == null ||
            !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(fechaTexto) ||
            fechaIngresada.year.toString().padLeft(4, '0') !=
                fechaTexto.substring(0, 4) ||
            fechaIngresada.month != int.parse(fechaTexto.substring(5, 7)) ||
            fechaIngresada.day != int.parse(fechaTexto.substring(8, 10))) {
          print('Error: la fecha no es válida.');
          datosValidos = false;
        } else {
          fechaNueva = DateTime(
            fechaIngresada.year,
            fechaIngresada.month,
            fechaIngresada.day,
            fechaNueva.hour,
            fechaNueva.minute,
          );
        }
        break;

      case '5':
        stdout.write('Nueva hora (HH:MM): ');
        String horaTexto = stdin.readLineSync() ?? '';

        List<String> partesHora = horaTexto.split(':');

        if (partesHora.length != 2) {
          print('Error: usa el formato HH:MM.');
          datosValidos = false;
          break;
        }

        int? hora = int.tryParse(partesHora[0]);
        int? minuto = int.tryParse(partesHora[1]);

        if (hora == null ||
            minuto == null ||
            hora < 0 ||
            hora > 23 ||
            minuto < 0 ||
            minuto > 59 ||
            partesHora[0].length != 2 ||
            partesHora[1].length != 2) {
          print('Error: ingresa una hora válida, por ejemplo 09:30.');
          datosValidos = false;
        } else {
          fechaNueva = DateTime(
            fechaNueva.year,
            fechaNueva.month,
            fechaNueva.day,
            hora,
            minuto,
          );
        }
        break;

      case '6':
        stdout.write('Nueva capacidad: ');
        String entrada = stdin.readLineSync() ?? '';
        int? capacidadIngresada = int.tryParse(entrada);

        if (capacidadIngresada == null || capacidadIngresada <= 0) {
          print('Error: la capacidad debe ser un entero mayor que cero.');
          datosValidos = false;
        } else {
          capacidadNueva = capacidadIngresada;
        }
        break;
    }
  }

  if (!datosValidos) {
    print('No se modificó el evento. Revisa los datos e inténtalo de nuevo.');
    return;
  }

  stdout.write('\n¿Confirmas los cambios realizados? (s/n): ');
  String confirmacion =
      (stdin.readLineSync() ?? '').trim().toLowerCase();

  if (confirmacion != 's') {
    print('Modificación cancelada. El evento conserva sus datos originales.');
    return;
  }

  eventoEncontrado.nombre = nombreNuevo;
  eventoEncontrado.categoria = categoriaNueva;
  eventoEncontrado.lugar = lugarNuevo;
  eventoEncontrado.fecha = fechaNueva;
  eventoEncontrado.capacidad = capacidadNueva;

  print('\n¡Evento modificado correctamente!');
  eventoEncontrado.mostrarInformacion();
}


void eliminarEvento() {
  print('\nELIMINAR EVENTO');

  if (eventos.isEmpty) {
    print('No hay eventos registrados para eliminar.');
    return;
  }

  stdout.write('Ingresa el código del evento que deseas eliminar: ');
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

  print('\nEvento que deseas eliminar:');
  eventoEncontrado.mostrarInformacion();

  stdout.write('\n¿Estás seguro de eliminar este evento? (s/n): ');
  String confirmacion =
      (stdin.readLineSync() ?? '').trim().toLowerCase();

  if (confirmacion == 's') {
    eventos.remove(eventoEncontrado);
    print('¡Evento eliminado correctamente!');
  } else if (confirmacion == 'n') {
    print('Operación cancelada. El evento se conserva.');
  } else {
    print('Respuesta no válida. El evento se conserva.');
  }
}
