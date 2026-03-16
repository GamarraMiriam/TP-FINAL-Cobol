# 🏦 Sistema de Actualización de Maestro de Clientes (COBOL)

### 📖 Descripción
Este proyecto consiste en un sistema de procesamiento **Batch** desarrollado en **COBOL**. Su función es gestionar la actualización de un archivo maestro de clientes mediante un archivo de novedades, aplicando una lógica de negocio para Altas, Bajas y Modificaciones (ABM).

### 📂 Estructura del Proyecto
Para el correcto funcionamiento en un entorno de desarrollo local (como **OpenCOBOLIDE**), los archivos deben estar organizados de la siguiente manera:
* `TP-FINAL.cbl`: Código fuente del programa.
* `CLIENTES.txt`: Archivo maestro con los datos actuales.
* `NOVEDADES.txt`: Archivo con las transacciones a procesar.

### ⚙️ Lógica de Procesamiento
El programa utiliza una estructura de control `EVALUATE` para determinar la acción según el tipo de novedad:
1. **Altas ('A'):** Incorpora nuevos registros previa validación de existencia.
2. **Bajas ('B'):** Elimina registros del flujo de salida para realizar una eliminación lógica.
3. **Modificaciones ('M'):** Actualiza los datos de clientes existentes.

### 📊 Control y Auditoría
Al finalizar el proceso, el sistema genera un reporte estadístico en consola que incluye:
* Total de registros leídos.
* Cantidad de Altas, Bajas y Modificaciones exitosas.
* Contador de errores encontrados durante el proceso.

### 🛠️ Ejecución
1. Abrir el proyecto en el IDE.
2. Compilar y ejecutar (F5).
3. Verificar el archivo resultante `SALIDA.txt` generado en la misma carpeta.