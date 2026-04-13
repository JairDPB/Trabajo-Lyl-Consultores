# CargueInfo - Extensión de Importación de Datos para Dynamics 365 Business Central

## 📋 Contexto General del Proyecto

**CargueInfo** es una extensión desarrollada en AL (Advanced Language) para Microsoft Dynamics 365 Business Central que facilita la importación masiva de datos financieros y maestros desde archivos externos (principalmente Excel). 

Este proyecto fue creado para **LyL Consultores** y proporciona una solución robusta para:
- Gestionar procesos de carga e importación de datos complejos
- Validar información antes de procesar en el sistema
- Mantener registros de auditoría de todas las importaciones
- Exponer funcionalidad de integración mediante APIs REST

### Información Técnica del Proyecto
- **Nombre**: CargueInfo
- **Versión**: 1.0.0.0
- **Editorial**: Default Publisher
- **Plataforma**: Business Central 27.0.0.0
- **Runtime**: AL 15.0
- **Rango de IDs de Objetos**: 50100-50149 (50 objetos disponibles)

---

## 🏗️ Estructura del Proyecto

```
CargueInfo/
├── app.json                           # Configuración principal de la extensión
├── Tables/                            # Tablas de datos personalizadas
│   ├── ImportJobHeaderTable.al        # Cabecera de trabajos de importación
│   └── L_ImportSaldosLineTable.al     # Líneas de importación (detalles)
├── Page/                              # Interfaces de usuario
│   ├── D365L_ImportJobCardPage.al     # Ficha de gestión de importación
│   └── D365L_ImportsaldoSupage.al     # Listado de líneas de importación
└── APIs/                              # Endpoints REST para integración
    ├── D365L_ImportJobHeaderAPIPage.al    # API para cabecera
    └── D365L_ImportSaldoAPIPage.al       # API para líneas
```

---

## 📊 Componentes Principales

### 1. TABLAS (Tables/)

#### **ImportJobHeaderTable** (Tabla 50148)
Tabla principal que almacena la información de cabecera de cada trabajo de importación.

**Propósito**: Mantener un registro central de todos los trabajos de importación con su estado y metadatos.

**Campos principales**:
| Campo | Tipo | Descripción |
|-------|------|-------------|
| Entry No. | Integer | ID único (autoincrementable) |
| Entity | Option | Tipo de entidad a importar: Saldos, Proveedores, Clientes, Items |
| Status | Option | Estado del proceso: Pendiente → Validando → Con Errores/Validado → Procesado |
| Import DateTime | DateTime | Fecha y hora de la importación |
| Imported By User | Code[50] | Usuario que realizó la importación |
| Source File Name | Text[250] | Nombre del archivo fuente importado |
| Gen. Jnl. Template | Code[10] | Plantilla de diario general a utilizar |
| Gen. Jnl. Batch | Code[10] | Lote de diario general a utilizar |
| Has Errors | Boolean | Indica si existen errores en las líneas |
| Lines Count | Integer | Total de líneas importadas |
| Valid Lines Count | Integer | Total de líneas válidas |
| Error Lines Count | Integer | Total de líneas con errores |

**Clave Primaria**: Entry No. (Clustered)

---

#### **L_ImportSaldosLineTable** (Tabla 50149)
Tabla de detalle que almacena cada línea de datos a importar relacionada con un trabajo.

**Propósito**: Registrar todos los registros individuales de una importación con su estado de validación y errores.

**Campos principales**:
| Campo | Tipo | Descripción |
|-------|------|-------------|
| Job Entry No. | Integer | Referencia a la cabecera (Tabla 50148) |
| Line No. | Integer | Número secuencial de línea |
| Excel Line No. | Integer | Número de fila en el archivo origen |
| Posting Date | Date | Fecha de registro contable |
| G/L Account No. | Code[20] | Número de cuenta contable (GL Account) |
| Document No. | Code[20] | Número de documento |
| Description | Text[100] | Descripción del movimiento |
| Amount | Decimal | Importe del movimiento |
| NIT | Code[20] | NIT de tercero (atributo tributario) |
| Dimension 1-8 Code | Code[20] | Campos de dimensión para análisis (1 a 8) |
| Line Status | Option | Estado: Pendiente → Válida/Error → Procesada |
| Technical Errors JSON | Blob/Memo | Errores técnicos en formato JSON |
| User Message | Text[250] | Mensaje legible para el usuario |
| Last Validation DateTime | DateTime | Última validación realizada |

**Clave Primaria**: (Job Entry No., Line No.) - Clustered

**Relaciones**:
- Referencia a tabla "D365L_Import Job Header" mediante "Job Entry No."
- Referencia a tabla estándar "G/L Account" para validación de cuentas

---

### 2. PÁGINAS DE USUARIO (Page/)

#### **D365L_Import Job Card** (Página 50148)
Interfaz principal para visualizar y gestionar trabajos de importación.

**Tipo**: Document (Ficha)
**SourceTable**: D365L_Import Job Header

**Estructura**:
1. **Grupo "General"**
   - Muestra información básica del trabajo importación
   - Entry No. (No editable)
   - Entity (tipo de entidad)
   - Status (estado actual)
   - Import DateTime (fecha/hora)
   - Imported By User (usuario responsable)
   - Source File Name (archivo origen)

2. **Grupo "Configuración"**
   - Gen. Jnl. Template (plantilla seleccionada)
   - Gen. Jnl. Batch (lote seleccionado)
   - Facilita la configuración del diario para procesar

3. **Grupo "Estadísticas y Errores"**
   - Has Errors (indicador visual)
   - Lines Count (total de líneas)
   - Valid Lines Count (líneas válidas)
   - Error Lines Count (líneas con problemas)

**Acciones**:
- **"Ver Líneas"**: Abre la página "D365L_Import Saldos Subpage" filtrando automáticamente las líneas del trabajo actual

---

#### **D365L_Import Saldos Subpage** (Página 50149)
Listado de líneas de importación con capacidad de edición y revisión.

**Tipo**: List (Página independiente)
**SourceTable**: D365L_Import Saldos Line

**Columnas visibles**:
- Job Entry No. (No editable)
- Line No. (No editable)
- Excel Line No.
- Posting Date
- Document No.
- G/L Account No.
- NIT
- Description
- Amount
- Line Status (Pendiente/Válida/Error/Procesada)
- User Message

**Acciones**:
- **"Ver Encabezado"**: Navega al Job Card correspondiente

**Métodos importantes**:
- `SetHeaderFilter(EntryNo: Integer)`: Filtra automáticamente las líneas de una cabecera específica

---

### 3. APIs REST (APIs/)

Las APIs están expuestas bajo el publisher **LyLConsultores**, grupo **integraciones**, versión **v1.0**.

#### **D365L_Import Job Header API** (Página 50141)
Endpoint REST para consultar y gestionar trabajos de importación.

**Tipo**: API
**SourceTable**: D365L_Import Job Header

**Configuración OData**:
- Entity Name: `importJob`
- Entity Set Name: `importJobs`
- APIPublisher: `LyLConsultores`
- APIGroup: `integraciones`
- APIVersion: `v1.0`
- ODataKeyFields: SystemId

**Campos expuestos**:
- id (SystemId - No editable)
- entryNo
- entity
- status
- importDateTime
- sourceFileName
- genJnlTemplate
- genJnlBatch

**Relaciones Anidadas**:
- `lines`: Relación con "D365L_Import Saldos Line API"
  - Filtraje automático mediante "Job Entry No."
  - Número de línea del diario

**URL de ejemplo**:
```
GET /api/LyLConsultores/integraciones/v1.0/importJobs
GET /api/LyLConsultores/integraciones/v1.0/importJobs({systemIdGuid})/lines
POST /api/LyLConsultores/integraciones/v1.0/importJobs
```

---

#### **D365L_Import Saldos Line API** (Página 50140)
Endpoint REST para líneas de importación con acceso directo.

**Tipo**: API
**SourceTable**: D365L_Import Saldos Line

**Configuración OData**:
- Entity Name: `importSaldoLine`
- Entity Set Name: `importSaldoLines`
- APIPublisher: `LyLConsultores`
- APIGroup: `integraciones`
- APIVersion: `v1.0`
- ODataKeyFields: SystemId

**Campos expuestos**:
- id (SystemId - No editable)
- jobEntryNo
- lineNo
- excelLineNo
- postingDate
- glAccountNo
- documentNo
- description
- amount
- nit
- lineStatus

**URL de ejemplo**:
```
GET /api/LyLConsultores/integraciones/v1.0/importSaldoLines
GET /api/LyLConsultores/integraciones/v1.0/importSaldoLines({systemIdGuid})
PATCH /api/LyLConsultores/integraciones/v1.0/importSaldoLines({systemIdGuid})
DELETE /api/LyLConsultores/integraciones/v1.0/importSaldoLines({systemIdGuid})
```

---

## 🔄 Flujo de Procesos

### Flujo de Importación Típico

```
1. INICIAR IMPORTACIÓN
   └─ Sistema externo → API "apiJob Header"
      └─ Crea nuevo registro en tabla "D365L_Import Job Header"
      └─ Status = "Pendiente"

2. CARGAR LÍNEAS
   └─ Sistema externo → API "Import Saldos Line"
      └─ Inserta registros en tabla "D365L_Import Saldos Line"
      └─ Cada línea con Status = "Pendiente"
      └─ Referencia a Job Entry No.

3. VALIDACIÓN
   └─ Validador BC ejecuta:
      ├─ Verifica cuentas GL existan
      ├─ Valida formatos de campos
      ├─ Verifica dimensiones (si aplica)
      └─ Actualiza "Line Status" (Válida/Error)

4. REVISIÓN DE ERRORES
   └─ Usuario abre Job Card
      ├─ Ve estadísticas (Lines Count, Error Lines Count)
      ├─ Visualiza líneas con error en subpage
      └─ Revisa "User Message" para cada línea problemática

5. PROCESAMIENTO
   └─ Usuario aprueba y sistema:
      ├─ Para líneas válidas → Procesa contablemente
      ├─ Status → "Procesada"
      ├─ Actualiza Job Header Status → "Procesado"
      └─ Genera asientos en diario

6. AUDITORÍA
   └─ Sistema mantiene:
      ├─ Registro histórico completo
      ├─ Trazabilidad mediante "Imported By User"
      ├─ Timestamps (Import DateTime, Last Validation DateTime)
      └─ Errores en "Technical Errors JSON"
```

---

## 🔐 Configuración del Proyecto (app.json)

```json
{
  "id": "6b7c9ae3-cfe7-4c98-8c5c-cca6c0ed8d04",
  "name": "CargueInfo",
  "publisher": "Default Publisher",
  "version": "1.0.0.0",
  "description": "", // Pendiente de llenar
  "platform": "1.0.0.0",
  "application": "27.0.0.0", // Business Central 27
  "runtime": "15.0",
  "idRanges": [
    { "from": 50100, "to": 50149 } // 50 objetos disponibles
  ],
  "features": ["NoImplicitWith"] // Requiere variables explícitas
}
```

**Políticas de Privacidad**:
- `allowDebugging`: true (permite debugging)
- `allowDownloadingSource`: true (permite descargar código fuente)
- `includeSourceInSymbolFile`: true (incluye fuente en símbolos)

---

## 📦 Entidades Soportadas

El proyecto actualmente soporta importación de los siguientes tipos de entidades:

| Entidad | Descripción |
|---------|-------------|
| **Saldos** | Saldos financieros / Movimientos contables |
| **Proveedores** | Datos maestros de proveedores |
| **Clientes** | Datos maestros de clientes/acreedores |
| **Items** | Datos maestros de artículos/productos |

Cada tipo de entidad puede tener validaciones y campos específicos.

---

## 🔗 Estados de Proceso

### Estados de Job Header

| Estado | Descripción |
|--------|-------------|
| **Pendiente** | Job creado, esperando carga de líneas |
| **Validando** | En proceso de validación de líneas |
| **Con Errores** | Validación completada con errores detectados |
| **Validado** | Todas las líneas pasaron validación |
| **Procesado** | Job completamente procesado y contabilizado |

### Estados de Línea

| Estado | Descripción |
|--------|-------------|
| **Pendiente** | Línea cargada, sin validar |
| **Válida** | Línea pasó todas las validaciones |
| **Error** | Línea tiene errores de validación |
| **Procesada** | Línea ha sido contabilizada/procesada |

---

## 🛠️ Componentes Técnicos

### Dimensiones Soportadas

La tabla de líneas soporta hasta **8 dimensiones** adicionales para análisis y clasificación:
- Dimension 1 Code - Dimension 8 Code (Code[20] cada una)

Estas se mapean a las dimensiones estándar de BC para contexto financiero.

### Validación y Errores

**Almacenamiento de errores**: Campo "Technical Errors JSON" (Blob)
- Permite registrar múltiples errores en formato JSON
- Facilita el debugging técnico

**Mensajes de usuario**: Campo "User Message" (Text[250])
- Mensaje legible y comprensible para usuarios de negocio
- Sugiere acciones correctivas

---

## 📝 Dependencias

El proyecto **NO tiene dependencias externas** más allá de las librerías estándar de Business Central:
- `Gen. Journal Template` (Tabla estándar BC)
- `Gen. Journal Batch` (Tabla estándar BC)
- `G/L Account` (Tabla estándar BC)

---

## 🚀 Casos de Uso Principales

1. **Importación de Saldos Iniciales**
   - Carga masiva de saldos de cuentas al abrir un nuevo libro de BC
   - Validación de cuentas GL vigentes
   - Procesamiento hacia diario contable

2. **Importación de Maestros**
   - Carga de proveedores, clientes e items desde sistemas externos
   - Validación de unicidad y datos requeridos

3. **Integración REST**
   - Sistemas externos pueden enviar datos directamente vía APIs
   - Seguimiento de importaciones en tiempo real
   - Consulta de estado de validación

4. **Auditoría y Trazabilidad**
   - Registro completo de quién importó qué y cuándo
   - Historial de cambios desde línea hasta procesamiento

---

## 📌 Próximos Pasos / Pendientes

- [ ] Completar descripción en `description` del app.json
- [ ] Implementar lógica de validación específica por tipo de entidad
- [ ] Desarrollar pantalla de estadísticas/dashboard
- [ ] Crear funcionalidad de corrección y reprocesso de errores
- [ ] Documentar APIs en Swagger/OpenAPI
- [ ] Implementar tests unitarios en AL
- [ ] Realizar tuning de rendimiento para importaciones masivas (>10K líneas)

---

## 👥 Información del Proyecto

- **Company**: LyL Consultores
- **Cliente**: [TBD]
- **Fecha de Creación**: [TBD]
- **Última Actualización**: Abril 2026
- **Desarrollador**: [TBD]

---

## 📄 Notas Finales

Este proyecto proporciona una base sólida y extensible para procesos de importación de datos masivos en Dynamics 365 Business Central. La arquitectura de dos tablas (cabecera y líneas) permite gestionar trabajos complejos con auditoría completa. Las APIs REST permiten integración fluida con sistemas externos.

**Para más información o consultas sobre funcionalidades específicas, contactar al equipo de desarrollo.**
