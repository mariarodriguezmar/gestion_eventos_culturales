import 'dart:io';
import 'package:gestion_eventos_culturales/gestion_eventos_culturales.dart' as gestion_eventos_culturales;

bool preguntarSiContinuar(String mensaje) {
  stdout.write(mensaje);
  String respuesta = (stdin.readLineSync() ?? '').trim().toLowerCase();

  while (respuesta != 's' && respuesta != 'n') {
    print('Respuesta no válida. Escribe s o n.');
    stdout.write(mensaje);
    respuesta = (stdin.readLineSync() ?? '').trim().toLowerCase();
  }

  return respuesta == 's';
}

void main(List<String> arguments) {
  gestion_eventos_culturales.cargarEventos();
  gestion_eventos_culturales.mostrarBienvenida();

  String opcion = '';

  while (opcion != '7') {
    print('\nMENÚ PRINCIPAL');
    print('1. Registrar evento');
    print('2. Listar eventos');
    print('3. Buscar evento');
    print('4. Modificar evento');
    print('5. Eliminar evento');
    print('6. Mostrar reporte');
    print('7. Salir');

    stdout.write('Selecciona una opción: ');
    opcion = stdin.readLineSync() ?? '';

    switch (opcion) {
      case '1':
        do {
          gestion_eventos_culturales.registrarEvento();
        } while (preguntarSiContinuar(
            '¿Deseas registrar otro evento? (s/n): '));
        break;

      case '2':
        do {
          gestion_eventos_culturales.listarEventos();
        } while (preguntarSiContinuar(
            '¿Deseas volver a listar los eventos? (s/n): '));
        break;

      case '3':
        do {
          gestion_eventos_culturales.buscarEvento();
        } while (preguntarSiContinuar(
            '¿Deseas realizar otra búsqueda? (s/n): '));
        break;

      case '4':
        do {
          gestion_eventos_culturales.modificarEvento();
        } while (preguntarSiContinuar(
            '¿Deseas realizar otra modificación? (s/n): '));
        break;

      case '5':
        do {
          gestion_eventos_culturales.eliminarEvento();
        } while (preguntarSiContinuar(
            '¿Deseas eliminar otro evento? (s/n): '));
        break;

      case '6':
        do {
          gestion_eventos_culturales.mostrarReporte();
        } while (preguntarSiContinuar(
            '¿Deseas volver a consultar el reporte? (s/n): '));
        break;
      case '7':
        print('Gracias por usar el sistema de gestión de eventos culturales.');
        break;

      default:
        print('Opción no válida. Selecciona un número del 1 al 7.');
    }
  }
}
