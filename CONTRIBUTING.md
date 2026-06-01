# Guía de Contribución

## 1. Convenciones de Commits (Conventional Commits)
Cada mensaje de commit debe seguir este formato:
`<tipo>: <descripción corta> - Nombre`

- **feat:** Nueva característica o funcionalidad.
- **fix:** Corrección de un error o bug.
- **docs:** Cambios solo en la documentación.
- **refactor:** Cambio en el código que no corrige errores ni añade funciones.
- **test:** Añadir pruebas o evidencias (capturas/logs).
- **build:** Cambios que afectan al sistema de construcción o dependencias.
- **chore:** Tareas de mantenimiento, configuración del entorno o herramientas.

Ejemplo: `feat: Añadir lógica de PID para control de motores`

## 2. Ramas (Branching Strategy)
* **main**: Rama principal para código estable y entregas finales.
* **dev**: Rama para integración de nuevas características.
* Crea ramas específicas para nuevas tareas: `feat/nombre-tarea` o `fix/nombre-error`.

## 3. Formato de Código
* **Verilog**: Mantén indentaciones de 4 espacios. Utiliza nombres de señales claros en minúsculas.
* **Documentación**: Todos los archivos nuevos deben seguir el formato Markdown y actualizarse en el `CHANGELOG.md`.

## 4. Proceso de Pull Request
1. Asegúrate de que todos los tests (`tests/run_tests.sh`) pasen correctamente.
2. Crea un Pull Request describiendo los cambios realizados.
3. Espera la revisión de un compañero antes de fusionar en `main`.

¡Mantengamos el repositorio limpio y documentado!
