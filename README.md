# CSL-Proyecto-SistemasDigitales

> **Carrito Velocista Seguidor de Línea con FPGA Tang Nano 9K**
> Proyecto de la Experiencia Educativa *Sistemas Digitales*.

## Descripción

Diseño e implementación en Verilog de un velocista seguidor de línea utilizando la FPGA
Tang Nano 9K (Gowin GW1NR-9). El sistema emplea un módulo de 5 sensores TCRT5000 para
detectar la posición de la línea y controlar dos motoreductores GA12-N20 a través del
puente H TB6612FNG.

## Estructura del repositorio

```
CSL-Proyecto-SistemasDigitales/
├── src/                           # Código fuente Verilog / restricciones
│   ├── pines_tangnano.cst         # Asignación de pines (Tang Nano 9K)
│   ├── top_velocista_no_opt.v     # Módulo principal v0.1.0
│   └── other_modules/             # Módulos auxiliares (PWM, FSM, etc.)
├── tests/                         # Testbenches de simulación
│   ├── tb_top_velocista.v         # Testbench para el módulo principal
│   └── run_tests.sh               # Script para ejecutar todas las pruebas
├── docs/                          # Documentación y diagramas
│   ├── instrucciones_montaje.md   # Guía de ensamble físico
│   └── datasheets/                # Referencias y fichas técnicas
├── hardware/                      # BOM y esquemáticos
│   ├── bom.csv                    # Lista de materiales (Bill of Materials)
│   ├── schematics/                # Archivos de esquemáticos
│   └── firmware/                  # Nota: código embarcado reside en src/
├── results/                       # Reportes de síntesis y simulación
│   ├── environment.txt            # Entorno de desarrollo
│   ├── synthesis_report.md        # Reporte de recursos y timing de Gowin
│   ├── raw/                       # Salidas crudas (VCD, logs de simulación)
│   └── plots/                     # Gráficos comparativos (PNG)
├── scripts/                       # Utilidades y automatización
│   ├── simulate.sh                # Compilar y simular con Icarus Verilog
│   ├── synthesize.sh              # Síntesis por línea de comandos (Gowin)
│   └── setup_env.sh               # Instalar herramientas de simulación
├── PROJECT.md                     # Objetivos, MVP y cronograma
├── AUTHORS.md                     # Integrantes del equipo
├── CHANGELOG.md                   # Historial de versiones
├── CONTRIBUTING.md                # Guía de contribución
└── LICENSE                        # Licencia MIT
```

## Requisitos de hardware

| Componente           | Referencia                       |
|----------------------|----------------------------------|
| FPGA                 | Tang Nano 9K (Gowin GW1NR-9)     |
| Puente H             | TB6612FNG 1.2 A                  |
| Sensores de línea    | TCRT5000 — módulo BFD-1000 (×5)  |
| Motoreductores       | GA12-N20 6 V (×2, kit)           |
| Regulador de voltaje | MP1584 DC-DC Step-Down 3 A       |
| Batería              | LiPo NanoTech 300 mAh 2S 7.4 V   |
| Ruedas locas         | 3pi N20 (×2, kit)                |
| Chasis               | Impresión 3D propia              |

Ver lista completa con proveedores en [`hardware/bom.csv`](hardware/bom.csv).

## Requisitos de software

| Herramienta        | Nota                                                        |
|--------------------|-------------------------------------------------------------|
| Gowin EDA          | V1.9.11.03 Education (Windows) — síntesis y programación    |
| Icarus Verilog     | Última versión estable — simulación open-source (opcional)  |
| GTKWave            | Última versión estable — visualización de formas de onda    |
| OpenFPGALoader     | Alternativa open-source a Gowin Programmer                  |

## Cómo sintetizar y programar

1. Abrir **Gowin EDA** e importar el proyecto (`.gprj`).
2. Agregar los archivos `.v` de `src/` y el archivo `.cst` de restricciones.
3. Ejecutar: *Synthesize → Place & Route → Generate Bitstream*.
4. Conectar la Tang Nano 9K por USB y cargar el bitstream `.fs` con **Gowin Programmer**.

## Cómo simular (Icarus Verilog)

```bash
# Instalar herramientas de simulación (ver scripts/setup_env.sh)
bash scripts/setup_env.sh

# Simular el módulo principal
bash scripts/simulate.sh

# Ejecutar todos los testbenches y generar resumen
bash tests/run_tests.sh
```

Los archivos `.vcd` generados en `results/raw/` se visualizan con GTKWave.

## Versión actual

`v0.1.0` - Prueba básica de motores. El carro avanza mientras el botón START
permanece presionado. La lógica de sensores se integrará en la versión 0.2.0.

## Licencia

MIT © Equipo 6 - ver [`LICENSE`](LICENSE).
