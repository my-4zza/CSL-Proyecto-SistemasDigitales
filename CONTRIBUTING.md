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
