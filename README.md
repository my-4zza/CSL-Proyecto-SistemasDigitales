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
├── src/                           # Código fuente Verilog y restricciones
│   ├── pines_tangnano.cst         # Asignación de pines (Tang Nano 9K)
│   └── top_velocista_no_opt.v     # Módulo principal v0.1.0
├── test/                          # Testbenches de simulación
│   ├── tb_top_velocista.v         # Testbench para el módulo principal
│   └── run_test.sh                # Script para ejecutar pruebas
├── docs/                          # Documentación y hojas de datos
│   ├── diagrama_bloques.png       # Diagrama de bloques del sistema
│   ├── TB6612FNG.pdf              # Datasheet del puente H
│   ├── lm393.pdf                  # Datasheet del comparador LM393
│   ├── mp1584-datasheet.pdf       # Datasheet del regulador step-down
│   ├── pololu-micro-metal...pdf   # Datasheet de los motoreductores
│   └── tcrt5000.pdf               # Datasheet de los sensores infrarrojos
├── hardware/                      # Lista de materiales y esquemáticos
│   ├── bom.csv                    # Lista de materiales (Bill of Materials)
│   └── schematics/
│       └── Mapa_Conexiones.pdf    # Diagrama de conexiones del hardware
├── results/                       # Reportes de síntesis y salidas de simulación
│   ├── dump.vcd                   # Archivo de formas de onda generado
│   ├── environment.txt            # Detalles del entorno
│   └── synthesis_report.txt       # Reporte de recursos y timing
├── scripts/                       # Utilidades y automatización
│   ├── deploy.sh                  # Script de despliegue
│   └── setup_env.sh               # Script de configuración del entorno
├── .gitignore                     # Archivos ignorados por Git
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

## Requisitos de software

| Herramienta | Nota |
| :--- | :--- |
| **Gowin EDA** | V1.9.11.03 Education (Windows) — síntesis y programación |
| **EDA Playground** | Plataforma web para simulación de código Verilog |
| **OpenFPGALoader** | Alternativa open-source a Gowin Programmer |

## Cómo sintetizar y programar

1. Abrir **Gowin EDA** e importar el proyecto (`.gprj`).
2. Agregar los archivos `.v` de `src/` y el archivo `.cst` de restricciones.
3. Ejecutar: *Synthesize → Place & Route → Generate Bitstream*.
4. Conectar la Tang Nano 9K por USB y cargar el bitstream `.fs` con **Gowin Programmer**.

## Cómo simular (EDA Playground)

Para la verificación lógica del diseño se utiliza la plataforma en la nube [EDA Playground](https://edaplayground.com/), eliminando la necesidad de instalar simuladores locales.

1. Ingresar a **EDA Playground** e iniciar sesión.
2. En la sección **Design** (panel derecho), pegar el código de `src/top_velocista_no_opt.v`.
3. En la sección **Testbench** (panel izquierdo), pegar el código de `test/tb_top_velocista.v`.
4. En el panel izquierdo (**Tools & Simulators**):
   * Seleccionar **Icarus Verilog** (versión recomendada 0.10.0 o superior).
   * Marcar la casilla **Open EPWave after run** para habilitar el visor de señales.
5. Hacer clic en el botón **Run** (arriba a la derecha). Al finalizar, se abrirá automáticamente la ventana con las formas de onda correspondientes al archivo `dump.vcd` generado.

Los archivos `.vcd` generados en `results/raw/` se visualizan con GTKWave.

## Licencia

MIT © Equipo 6 - ver [`LICENSE`](LICENSE).
