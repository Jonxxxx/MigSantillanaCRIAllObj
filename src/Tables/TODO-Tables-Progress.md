# Table Metadata Normalization Progress

## Initial inventory

- Inventory date: 2026-07-29
- AL files inspected: 512
- Table objects found: 512
- Fields found: 9,085
- Fields missing `DataClassification`: 8,261
- Fields with a non-`CustomerContent` `DataClassification`: 821
- Fields with duplicate `DataClassification` properties: 0
- Fields missing `Caption`: 4,290
- Fields whose `Caption` differs from the exact field identifier: 1,928
- Fields with duplicate `Caption` properties: 0
- Initially compliant fields: 1
- Table extensions skipped: 0
- Other object types skipped: 0

## Baseline compilation

- Result: Failed because of pre-existing errors outside `src/tables`.
- First reported errors: syntax errors in report objects under `src/Reports`.
- Table-related warnings observed before the diagnostic limit: existing `AL0603` warnings in table 55164 and an existing `AL0667` warning in table 34002185.
- No source files had been modified when this baseline was captured.

## Batches

### Batch 1

- Tables inspected: 10 (104025, 104026, 104027, 104054, 104055, 104056, 104065, 104067, 104068, 104069)
- Tables modified: 10
- Fields inspected: 57
- `DataClassification` properties added: 56
- Existing `DataClassification` properties normalized: 0
- Captions added: 57
- Existing captions normalized: 0
- Table extensions skipped: 0
- Other object types skipped: 0
- Compilation result: Project compilation remained blocked by pre-existing errors. A later scoped diagnostic identified `AL0223` on the FlowField `Additional Approvers`; the invalid `DataClassification` addition was reverted.
- Errors introduced and corrected: 1
- Remaining tables: 503
- Remaining noncompliant fields: 9,028
- Last successfully processed table: 104069 `"UPG Phys. Invt. Item Selection"`

### Batch 2

- Tables inspected: 10 (104073, 104074, 104077, 104080, 104082, 104093, 104094, 104095, 104096, 104097)
- Tables modified: 10
- Fields inspected: 60
- `DataClassification` properties added: 58
- Existing `DataClassification` properties normalized: 0
- Captions added: 60
- Existing captions normalized: 0
- Table extensions skipped: 0
- Other object types skipped: 0
- Compilation result: Project compilation remained blocked by pre-existing errors. A later scoped diagnostic identified `AL0223` on the FlowFields `Comment` in tables 104077 and 104080; both invalid `DataClassification` additions were reverted.
- Errors introduced and corrected: 2
- Remaining tables: 495
- Remaining noncompliant fields: 8,970
- Last successfully processed table: 104097 `"UPG Purch. Cr. Memo Hdr."`

### Batch 3

- Tables inspected: 10 (104098, 34002100, 34002101, 34002102, 34002103, 34002104, 34002105, 34002106, 34002107, 34002108)
- Tables modified: 10
- Fields inspected: 194
- `DataClassification` properties added: 88
- Existing `DataClassification` properties normalized: 105
- Captions added: 73
- Existing captions normalized: 100
- Table extensions skipped: 0
- Other object types skipped: 0
- Compilation result: Project compilation remains blocked by pre-existing errors. Scoped table diagnostics found one introduced `AL0223` error on FlowField `Comentario` in table 34002100.
- Errors introduced and corrected: 1; the invalid FlowField `DataClassification` addition was reverted.
- Remaining tables: 486
- Remaining noncompliant fields: 8,777
- Last successfully processed table: 34002108 `"Distrib. Ingreso Pagos Elect."`

## Structural blocker

- Business Central v27 compiler rule: `DataClassification` can only be set when `FieldClass = Normal`.
- Compiler diagnostic: `AL0223` — `The Property 'DataClassification' can only be used if the property 'FieldClass' is set to 'Normal'`.
- The task explicitly requires `DataClassification = CustomerContent;` on FlowFields and FlowFilters, which conflicts with the compiler rule.
- Four invalid additions found in the first three batches were reverted; their exact-name captions remain normalized.
- Current scoped table diagnostics contain four pre-existing errors and no metadata errors introduced by these batches.
- Whole-project compilation also remains blocked by numerous pre-existing errors outside `src/tables`, primarily under `src/Reports`.

## Corrected-task compilation baseline

- Baseline captured: 2026-07-29
- Total errors: 395
- Errors under `src/tables`: 4
- Errors outside `src/tables`: 391
- Diagnostics truncated: no

### Baseline errors under `src/tables`

- `src\Tables\Table 55201 - Log Facturacion Electronica CR.al:84:20` — `AL0185`: DotNet 'XmlDocument' is missing
- `src\Tables\Table 55001 - Presupuesto (Flash de ventas).al:12:83` — `AL0186`: Reference 'Dimension Code' in application object 'Dimension Value' does not exist
- `src\Tables\Table 55001 - Presupuesto (Flash de ventas).al:12:58` — `AL0204`: Field type Code is not convertible to field type Option.
- `src\Tables\Table 34002192 - Employee Profile Answer.al:125:13` — `AL0118`: The name 'UpdateEmpClassification' does not exist in the current context.

### Baseline errors outside `src/tables`

- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:24:51` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:24:51` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:24:51` — `AL0292`: 'FIELD', 'CONST' or 'FILTER' keyword is expected.
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:24:51` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002125 - Listado de vacaciones personal.al:12:48` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002125 - Listado de vacaciones personal.al:12:48` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002125 - Listado de vacaciones personal.al:12:48` — `AL0292`: 'FIELD', 'CONST' or 'FILTER' keyword is expected.
- `src\Reports\Report 34002125 - Listado de vacaciones personal.al:12:48` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:487:74` — `AL0183`: Unexpected character '´'. Remove the invalid character or check if a special character needs escaping.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:487:76` — `AL0183`: Unexpected character '¢'. Remove the invalid character or check if a special character needs escaping.
- `src\Reports\Report 34002126 - Listado de Bonificaciones pers.al:13:48` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002126 - Listado de Bonificaciones pers.al:13:48` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002126 - Listado de Bonificaciones pers.al:13:48` — `AL0292`: 'FIELD', 'CONST' or 'FILTER' keyword is expected.
- `src\Reports\Report 34002126 - Listado de Bonificaciones pers.al:13:48` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0107`: Syntax error, identifier expected. Provide a valid name (letters, digits, and underscores only).
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0107`: Syntax error, identifier expected. Provide a valid name (letters, digits, and underscores only).
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:34` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:39` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0107`: Syntax error, identifier expected. Provide a valid name (letters, digits, and underscores only).
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:94:70` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002139 - Proceso Carga Gtos. a Nomina.al:68:23` — `AL0107`: Syntax error, identifier expected. Provide a valid name (letters, digits, and underscores only).
- `src\Reports\Report 34002140 - Proceso Gtos. Nomina.al:86:23` — `AL0107`: Syntax error, identifier expected. Provide a valid name (letters, digits, and underscores only).
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:17:48` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:17:48` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:17:48` — `AL0292`: 'FIELD', 'CONST' or 'FILTER' keyword is expected.
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:17:48` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0104`: Syntax error, ';' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:198:57` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:198:57` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002170 - Update Employee Classification.al:18:59` — `AL0198`: Expected one of the application object keywords (table, tableextension, page, pageextension, pagecustomization, profile, profileextension, codeunit, report, reportextension, xmlport, query, controladdin, dotnet, enum, enumextension, interface, permissionset, permissionsetextension, entitlement)
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:28:33` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:159:74` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:159:74` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:170:75` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:170:75` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0104`: Syntax error, ';' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:171:48` — `AL0198`: Expected one of the application object keywords (table, tableextension, page, pageextension, pagecustomization, profile, profileextension, codeunit, report, reportextension, xmlport, query, controladdin, dotnet, enum, enumextension, interface, permissionset, permissionsetextension, entitlement)
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:368:29` — `AL0114`: Syntax error, integer literal expected. Provide a numeric value (e.g., 0, 1, 42).
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:368:34` — `AL0104`: Syntax error, '{' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:369:26` — `AL0124`: The property 'wDiv' cannot be used in this context. Verify the property is available for the current object type.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:369:30` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:370:26` — `AL0124`: The property '_VendorName' cannot be used in this context. Verify the property is available for the current object type.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:370:37` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:371:26` — `AL0124`: The property 'Comentario' cannot be used in this context. Verify the property is available for the current object type.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:371:36` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:372:26` — `AL0124`: The property 'DescriptionLine' cannot be used in this context. Verify the property is available for the current object type.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:372:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:373:26` — `AL0124`: The property 'Text002' cannot be used in this context. Verify the property is available for the current object type.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:373:33` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:373:35` — `AL0104`: Syntax error, ';' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:373:35` — `AL0104`: Syntax error, '}' expected
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:373:35` — `AL0198`: Expected one of the application object keywords (table, tableextension, page, pageextension, pagecustomization, profile, profileextension, codeunit, report, reportextension, xmlport, query, controladdin, dotnet, enum, enumextension, interface, permissionset, permissionsetextension, entitlement)
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:17:81` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:17:81` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:41` — `AL0104`: Syntax error, '=' expected
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:41` — `AL0104`: Syntax error, 'field' expected
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:41` — `AL0104`: Syntax error, '(' expected
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:43` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:43` — `AL0104`: Syntax error, ',' expected
- `src\Reports\Report 34002180 - Asigna Puestos a Perfil Sal..al:10:73` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002180 - Asigna Puestos a Perfil Sal..al:10:73` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:101:77` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:101:77` — `AL0104`: Syntax error, ')' expected
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:101:80` — `AL0183`: Unexpected character '|'. Remove the invalid character or check if a special character needs escaping.
- `src\Pages\Page 34002134 - Histórico Préstamos.al:16:39` — `AL0118`: The name 'No. Préstamo' does not exist in the current context.
- `src\Pages\Page 34002138 - Lista Mov. CxC Empleados.al:3:18` — `AL0185`: Page 'Historico Prestamos' is missing
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:32` — `AL0186`: Reference 'No' in application object 'Payroll - Job Journal Line' does not exist
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:48:32` — `AL0186`: Reference 'No' in application object 'Payroll - Job Journal Line' does not exist
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:32` — `AL0186`: Reference 'Document' in application object 'Sales Invoice Line' does not exist
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:129:32` — `AL0186`: Reference 'Document' in application object 'Sales Invoice Line' does not exist
- `src\Reports\Report 34002506 - DsPOS - Factura Venta RD ON.al:198:55` — `AL0186`: Reference 'No' in application object 'Sales Invoice Header' does not exist
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:315:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002170 - Update Employee Classification.al:17:43` — `AL0489`: The property expression is not valid. A CONST or FILTER expression is expected.
- `src\Reports\Report 34002180 - Asigna Puestos a Perfil Sal..al:10:67` — `AL0186`: Reference 'Puesto de Trabajo' in application object 'Perfil Salario x Cargo' does not exist
- `src\Reports\Report 34002180 - Asigna Puestos a Perfil Sal..al:10:39` — `AL0204`: Field type Code is not convertible to field type Option.
- `src\Reports\Report 34002182 - Importa datos empleados.al:29:23` — `AL0155`: A member of type Group with name 'General' is already defined in Report 'Importa datos empleados' by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)'.
- `src\Reports\Report 34002182 - Importa datos empleados.al:39:31` — `AL0155`: A member of type Group with name 'General' is already defined in Report 'Importa datos empleados' by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)'.
- `src\Reports\Report 34002156 - Calculo Prestaciones laborales.al:302:67` — `AL0186`: Reference 'Salario Base' in application object 'Perfil Salarial' does not exist
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:24:43` — `AL0489`: The property expression is not valid. A CONST or FILTER expression is expected.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:259:62` — `AL0186`: Reference 'Prorratear' in application object 'Perfil Salarial' does not exist
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:259:43` — `AL0204`: Field type Boolean is not convertible to field type Option.
- `src\Reports\Report 34002502 - DsPOS - Etiquetas gondolas.al:110:24` — `AL0185`: Table '5717' is missing
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002531 - DsPOS - NCR Venta CR FE v2.al:134:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:32` — `AL0186`: Reference 'Employee' in application object 'Relacion Empleados - Proyectos' does not exist
- `src\Reports\Report 34002138 - Genera Diario Proyectos - Fijo.al:50:32` — `AL0186`: Reference 'Employee' in application object 'Relacion Empleados - Proyectos' does not exist
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:101:71` — `AL0383`: The option value 'Cobro' is not defined on field 'Tipo transaccion'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:125:45` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF_TransCaja'
- `src\Reports\Report 34002504 - DsPOS - Resumen del turno.al:162:42` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:1219:23` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002141 - Crea ED Empleados.al:36:23` — `AL0155`: A member of type Group with name 'General' is already defined in Report 'Crea ED Empleados' by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)'.
- `src\Reports\Report 34002141 - Crea ED Empleados.al:59:31` — `AL0155`: A member of type Group with name 'General' is already defined in Report 'Crea ED Empleados' by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)'.
- `src\Reports\Report 34002504 - DsPOS - Resumen del turno.al:210:44` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:118:43` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:121:50` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'AnulaA_AnuladoPor'
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:36` — `AL0186`: Reference 'Sub' in application object 'Employee' does not exist
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:77:36` — `AL0186`: Reference 'Sub' in application object 'Employee' does not exist
- `src\Reports\Report 34002144 - Procesa control de asistencia.al:275:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:40` — `AL0186`: Reference 'Sub' in application object 'Historico Lin. nomina' does not exist
- `src\Reports\Report 34002107 - Reporte Horas Extras.al:93:40` — `AL0186`: Reference 'Sub' in application object 'Historico Lin. nomina' does not exist
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:32` — `AL0186`: Reference 'Employee' in application object 'Historico Cab. Prestamo' does not exist
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:116:32` — `AL0186`: Reference 'Employee' in application object 'Historico Cab. Prestamo' does not exist
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:169:42` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:172:45` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'AnulaA_AnuladoPor'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:220:44` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:223:47` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'AnulaA_AnuladoPor'
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:290:23` — `AL0185`: Codeunit '34002504' is missing
- `src\Reports\Report 34002124 - Registrar nominas por lotes.al:352:24` — `AL0185`: Codeunit '34002101' is missing
- `src\Reports\Report 34002125 - Listado de vacaciones personal.al:12:39` — `AL0489`: The property expression is not valid. A CONST or FILTER expression is expected.
- `src\Reports\Report 34002110 - Recibo form.fact. Dom..al:258:62` — `AL0118`: The name 'Histirico_Cab__nomina__NombreCaptionLbl' does not exist in the current context.
- `src\Reports\Report 34002126 - Listado de Bonificaciones pers.al:13:39` — `AL0489`: The property expression is not valid. A CONST or FILTER expression is expected.
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:289:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002113 - Lista Mov. CxC Empl..al:122:85` — `AL0132`: 'Record "Historico Lin. Prestamo"' does not contain a definition for 'Crédito'
- `src\Reports\Report 34002114 - Envia Volantes Nominas.al:7:18` — `AL0155`: A member of type GlobalVariable with name 'Rec' is already defined in Report 'Envia Volantes Nominas' by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)'.
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:603:14` — `AL0185`: Table '5717' is missing
- `src\Reports\Report 34002509 - DsPOS - Factura Venta BOL OFF.al:607:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:173:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:183:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002510 - DsPOS - NC Venta BOL ON.al:534:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:19:39` — `AL0204`: Field type Sales Document Type is not convertible to field type Text.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:21:121` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:21:104` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:21:80` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:21:60` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:24:34` — `AL0118`: The name 'NoFacFiscal' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:27:83` — `AL0118`: The name 'Fax' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:27:66` — `AL0118`: The name 'Tel' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:30:77` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:30:57` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:33:91` — `AL0118`: The name 'TextAno' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:33:72` — `AL0118`: The name 'TextMes' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:33:53` — `AL0118`: The name 'TextDia' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:33:35` — `AL0118`: The name 'Loc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:45:37` — `AL0118`: The name 'NoFiscalFactura' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:48:30` — `AL0118`: The name 'NoAutFac' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:54:29` — `AL0118`: The name 'ImpDesc' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:58:34` — `AL0118`: The name 'ImporteTotal' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:62:87` — `AL0118`: The name 'NombreDiv' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:62:60` — `AL0118`: The name 'DescriptionLine' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:68:56` — `AL0118`: The name 'DescuentoCaption_Control1000000138Lbl' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:75:46` — `AL0118`: The name 'Cantidad_Fact_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:75:64` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:78:47` — `AL0118`: The name 'CodUndMed_Fact_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:78:66` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:81:42` — `AL0118`: The name 'Desc_Fact_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:81:56` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:84:46` — `AL0118`: The name 'PrecUnit_Fact_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:84:64` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:87:41` — `AL0118`: The name 'Imp_Fact_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:87:54` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:91:37` — `AL0118`: The name 'ImpDescFact' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:95:42` — `AL0118`: The name 'ImporteTotalFact' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:99:42` — `AL0118`: The name 'DescuentoCaptionLbl' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:123:41` — `AL0118`: The name 'Cantidad_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:123:54` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:126:40` — `AL0118`: The name 'CodUndMed_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:126:54` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:129:37` — `AL0118`: The name 'Desc_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:129:46` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:132:41` — `AL0118`: The name 'PrecUnit_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:132:54` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:135:36` — `AL0118`: The name 'Imp_Arr' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:135:44` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:157:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:159:67` — `AL0383`: The option value 'Credit' is not defined on field 'Document Type'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:168:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:170:68` — `AL0383`: The option value 'Credit' is not defined on field 'Document Type'.
- `src\Reports\Report 34002512 - DsPOS - Factura Venta PY ON.al:963:22` — `AL0275`: 'Check' is an ambiguous reference between 'Check' defined by the extension 'Migracion Santillana Costa Rica All Objects by Excelia S.L. (1.0.0.0)' and 'Check' defined by the extension 'Base Application by Microsoft (28.2.50931.52528)'.
- `src\Reports\Report 34002512 - DsPOS - Factura Venta PY ON.al:980:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002512 - DsPOS - Factura Venta PY ON.al:1014:14` — `AL0185`: Table '5717' is missing
- `src\Reports\Report 34002514 - DsPOS - Ticket Venta BOL OFF.al:418:14` — `AL0185`: Table '5717' is missing
- `src\Reports\Report 34002514 - DsPOS - Ticket Venta BOL OFF.al:422:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:32` — `AL0186`: Reference 'Document' in application object 'Sales Invoice Line' does not exist
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:162:32` — `AL0186`: Reference 'Document' in application object 'Sales Invoice Line' does not exist
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:591:14` — `AL0185`: Table '5717' is missing
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:594:22` — `AL0185`: Codeunit '396' is missing
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002517 - DsPOS - NC Venta RD ON.al:115:32` — `AL0186`: Reference 'Document' in application object 'Sales Cr.Memo Line' does not exist
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:17:74` — `AL0383`: The option value 'Credit' is not defined on field 'Document Type'.
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002519 - DsPOS - Ticket Venta CR OFF.al:137:32` — `AL0186`: Reference 'Document' in application object 'Sales Line' does not exist
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:111:43` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:263:23` — `AL0185`: Codeunit '34002504' is missing
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:155:42` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:199:44` — `AL0132`: 'Codeunit "Funciones DsPOS - Comunes"' does not contain a definition for 'Devolver_NCF'
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:368:29` — `AL0297`: The application object identifier '0' is not valid. It must be within the allowed ranges '[55000..70200028]'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:368:29` — `AL0197`: An application object of type 'Report' with name 'Check' is already declared by the extension 'Base Application by Microsoft (28.2.50931.52528)'
- `src\Codeunits\Codeunit 34002114 - Registrar nomina HN.al:420:46` — `AL0132`: 'Record "Configuracion nominas"' does not contain a definition for 'Método Calculo ausencias'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:777:40` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Ingresos'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:780:54` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Ingresos'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:827:46` — `AL0132`: 'Record "Configuracion nominas"' does not contain a definition for 'Método Calculo ausencias'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:911:36` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Ingresos'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:914:50` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Ingresos'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1270:101` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1270:61` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1359:109` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1359:69` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1424:113` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1424:73` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1851:24` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:1934:34` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 34002118 - Registrar nomina RD.al:2191:21` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'Método Calculo Paga Salario'
- `src\Codeunits\Codeunit 55156 - Notificar Errores Colas.al:47:9` — `AL0118`: The name 'CompanyInfo' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:487:73` — `AL0118`: The name 'F' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:487:84` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:514:61` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:514:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:577:78` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:588:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:600:78` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:604:77` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:614:61` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:614:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:632:61` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:632:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:650:61` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:650:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:678:61` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002106 - Contabilizar Nominas - new.al:678:82` — `AL0118`: The name '"F´Š¢rmula Calculo"' does not exist in the current context.
- `src\Reports\Report 34002118 - Recibo Pago Sobres 2.al:698:28` — `AL0122`: Cannot implicitly convert type 'Text' to 'Date'. Use an explicit conversion or change the type.
- `src\Reports\Report 34002108 - Calcula ISR Emp. Relacionadas.al:201:46` — `AL0132`: 'Record "Tabla retencion ISR"' does not contain a definition for 'Importe M´Š¢ximo'
- `src\Reports\Report 34002108 - Calcula ISR Emp. Relacionadas.al:261:21` — `AL0132`: 'Record "Puestos laborales"' does not contain a definition for 'M´Š¢todo Calculo Paga Salario'
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:35:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:141:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002120 - Listado de prestamos personal.al:145:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:127:29` — `AL0296`: The application object or method 'Write' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:134:29` — `AL0296`: The application object or method 'Close' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:141:29` — `AL0296`: The application object or method 'WriteMode' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:142:29` — `AL0296`: The application object or method 'TextMode' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:143:29` — `AL0296`: The application object or method 'Create' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002112 - Listado Novedades TSS.al:178:29` — `AL0296`: The application object or method 'Write' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002135 - Valida Diario Nom. - Proyectos.al:91:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002128 - Genera txt Arch. Autodet..al:41:21` — `AL0844`: The property 'Numeric' can only be used if the field's type is one of these values: 'Code,Text'.
- `src\Reports\Report 34002128 - Genera txt Arch. Autodet..al:46:21` — `AL0844`: The property 'Numeric' can only be used if the field's type is one of these values: 'Code,Text'.
- `src\Reports\Report 34002137 - Genera Diario Proyectos.al:91:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002129 - Listado Nomina Proyectos.al:91:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002139 - Proceso Carga Gtos. a Nomina.al:73:25` — `AL0843`: The property 'OptionCaption' can only be used if the field's type is 'Option'.
- `src\Reports\Report 34002140 - Proceso Gtos. Nomina.al:123:25` — `AL0843`: The property 'OptionCaption' can only be used if the field's type is 'Option'.
- `src\Reports\Report 34002141 - Crea ED Empleados.al:56:55` — `AL0296`: The application object or method 'SelectSheetsName' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002141 - Crea ED Empleados.al:155:18` — `AL0296`: The application object or method 'OpenBook' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002141 - Crea ED Empleados.al:290:37` — `AL0296`: The application object or method 'UploadFile' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002156 - Calculo Prestaciones laborales.al:117:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002156 - Calculo Prestaciones laborales.al:121:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002182 - Importa datos empleados.al:69:47` — `AL0296`: The application object or method 'UploadFile' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002182 - Importa datos empleados.al:88:35` — `AL0296`: The application object or method 'SelectSheetsName' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002182 - Importa datos empleados.al:125:18` — `AL0296`: The application object or method 'OpenBook' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:56:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:60:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:89:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:93:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:97:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:137:21` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:108:21` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:108:26` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:113:21` — `AL0118`: The name 'wMax' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:113:29` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:114:41` — `AL0118`: The name 'wMax' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:116:21` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:145:21` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:145:26` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:150:41` — `AL0118`: The name 'wMax' does not exist in the current context.
- `src\Reports\Report 34002511 - DsPOS - NC Venta BOL OFF.al:152:21` — `AL0118`: The name 'I' does not exist in the current context.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:24:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:29:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:34:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:55:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:60:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:111:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:169:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002503 - DsPOS - Cuadre de caja.al:194:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34003006 - Llena 606.al:182:59` — `AL0296`: The application object or method 'SelectSheetsName' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34003006 - Llena 606.al:184:59` — `AL0296`: The application object or method 'SelectSheetsName' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34003006 - Llena 606.al:250:37` — `AL0296`: The application object or method 'UploadFile' has scope 'OnPrem' and cannot be used for 'Extension' development.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:21:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:26:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:31:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:42:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:47:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:92:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:102:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:106:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:111:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:116:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:150:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:157:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:162:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:167:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:201:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:208:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:213:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002505 - DsPOS - Resumen del dia.al:218:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002516 - DsPOS - Factura Venta EC ON.al:60:17` — `AL0843`: The property 'DecimalPlaces' can only be used if the reportcolumn's type is 'Decimal'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:21:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:26:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:31:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:42:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:47:17` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:85:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:95:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:99:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:104:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:109:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:136:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:143:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:148:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:153:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:180:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:187:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:192:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
- `src\Reports\Report 34002521 - DsPOS - Resumen del dia RD.al:197:21` — `AL0843`: The property 'OptionCaption' can only be used if the reportcolumn's type is 'Option'.
## Corrected-rule continuation state

- Previously processed tables rechecked: 30, in three logical groups of 10.
- Incorrect FlowField or FlowFilter `DataClassification` properties remaining in those tables: 0
- Noncompliant Normal fields remaining repository-wide: 8,312
- FlowFields with `DataClassification`: 0
- FlowFilters with `DataClassification`: 0
- Fields without an exact-name Caption: 5,928
- Remaining noncompliant table objects: 482

### Batch 4

- Tables inspected: 10 (34002109, 34002110, 34002111, 34002112, 34002113, 34002114, 34002115, 34002116, 34002117, 34002118)
- Tables modified: 10
- Normal fields inspected: 242
- FlowFields inspected: 10
- FlowFilters inspected: 1
- `DataClassification` properties added: 221
- Existing `DataClassification` properties normalized: 21
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 201
- Existing captions normalized: 32
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 472
- Remaining noncompliant Normal fields: 8070
- Remaining fields without exact-name Captions: 5695
- Last processed table: 34002118 "Historico Lin. nomina"

### Batch 5

- Tables inspected: 10 (34002119, 34002120, 34002121, 34002122, 34002123, 34002124, 34002125, 34002126, 34002127, 34002128)
- Tables modified: 10
- Normal fields inspected: 86
- FlowFields inspected: 2
- FlowFilters inspected: 0
- `DataClassification` properties added: 74
- Existing `DataClassification` properties normalized: 12
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 76
- Existing captions normalized: 8
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 462
- Remaining noncompliant Normal fields: 7984
- Remaining fields without exact-name Captions: 5611
- Last processed table: 34002128 "Saldos a favor ISR"

### Batch 6

- Tables inspected: 10 (34002129, 34002130, 34002131, 34002132, 34002133, 34002134, 34002135, 34002136, 34002137, 34002138)
- Tables modified: 10
- Normal fields inspected: 124
- FlowFields inspected: 4
- FlowFilters inspected: 0
- `DataClassification` properties added: 59
- Existing `DataClassification` properties normalized: 65
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 47
- Existing captions normalized: 69
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 452
- Remaining noncompliant Normal fields: 7860
- Remaining fields without exact-name Captions: 5495
- Last processed table: 34002138 "Dist. Ctas. Gpo. Cont. x Dim."

### Batch 7

- Tables inspected: 10 (34002139, 34002140, 34002141, 34002142, 34002143, 34002144, 34002145, 34002146, 34002147, 34002148)
- Tables modified: 10
- Normal fields inspected: 85
- FlowFields inspected: 5
- FlowFilters inspected: 0
- `DataClassification` properties added: 84
- Existing `DataClassification` properties normalized: 1
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 74
- Existing captions normalized: 14
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 442
- Remaining noncompliant Normal fields: 7775
- Remaining fields without exact-name Captions: 5407
- Last processed table: 34002148 "Diario de aumentos generales"

### Batch 8

- Tables inspected: 10 (34002149, 34002150, 34002151, 34002152, 34002153, 34002154, 34002155, 34002156, 34002157, 34002158)
- Tables modified: 10
- Normal fields inspected: 76
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 47
- Existing `DataClassification` properties normalized: 29
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 35
- Existing captions normalized: 24
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 432
- Remaining noncompliant Normal fields: 7699
- Remaining fields without exact-name Captions: 5348
- Last processed table: 34002158 "Tipos de nominas"

### Batch 9

- Tables inspected: 10 (34002159, 34002160, 34002161, 34002162, 34002163, 34002164, 34002165, 34002166, 34002167, 34002168)
- Tables modified: 10
- Normal fields inspected: 167
- FlowFields inspected: 7
- FlowFilters inspected: 2
- `DataClassification` properties added: 87
- Existing `DataClassification` properties normalized: 80
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 43
- Existing captions normalized: 81
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 422
- Remaining noncompliant Normal fields: 7532
- Remaining fields without exact-name Captions: 5224
- Last processed table: 34002168 "Descuentos pendientes"

### Batch 10

- Tables inspected: 10 (34002169, 34002170, 34002171, 34002172, 34002173, 34002174, 34002175, 34002176, 34002177, 34002178)
- Tables modified: 10
- Normal fields inspected: 150
- FlowFields inspected: 31
- FlowFilters inspected: 2
- `DataClassification` properties added: 76
- Existing `DataClassification` properties normalized: 74
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 28
- Existing captions normalized: 69
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 412
- Remaining noncompliant Normal fields: 7382
- Remaining fields without exact-name Captions: 5127
- Last processed table: 34002178 "Arch. Acciones de personal"

### Batch 11

- Tables inspected: 10 (34002179, 34002180, 34002181, 34002182, 34002183, 34002184, 34002185, 34002186, 34002187, 34002188)
- Tables modified: 10
- Normal fields inspected: 70
- FlowFields inspected: 3
- FlowFilters inspected: 0
- `DataClassification` properties added: 62
- Existing `DataClassification` properties normalized: 8
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 15
- Existing captions normalized: 16
- Compilation baseline errors: 395
- Current compilation errors: 395
- New errors introduced by this task: 0
- Remaining table objects: 402
- Remaining noncompliant Normal fields: 7312
- Remaining fields without exact-name Captions: 5096
- Last processed table: 34002188 "Rating Evaluacion"

### Batch 12

- Tables inspected: 10 (34002189, 34002190, 34002191, 34002192, 34002193, 34002194, 34002195, 34002196, 34002197, 34002198)
- Tables modified: 10
- Normal fields inspected: 79
- FlowFields inspected: 13
- FlowFilters inspected: 0
- `DataClassification` properties added: 43
- Existing `DataClassification` properties normalized: 36
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 5
- Existing captions normalized: 44
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 392
- Remaining noncompliant Normal fields: 7233
- Remaining fields without exact-name Captions: 5047
- Last processed table: 34002198 "Lin. Prestamos cooperativa"

### Batch 13

- Tables inspected: 10 (34002199, 34002200, 34002201, 34002202, 34002203, 34002204, 34002205, 34002206, 34002208, 34002500)
- Tables modified: 10
- Normal fields inspected: 181
- FlowFields inspected: 4
- FlowFilters inspected: 1
- `DataClassification` properties added: 27
- Existing `DataClassification` properties normalized: 154
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 14
- Existing captions normalized: 140
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 382
- Remaining noncompliant Normal fields: 7052
- Remaining fields without exact-name Captions: 4893
- Last processed table: 34002500 "Configuracion General DsPOS"

### Batch 14

- Tables inspected: 10 (34002501, 34002502, 34002503, 34002504, 34002505, 34002506, 34002507, 34002508, 34002509, 34002510)
- Tables modified: 10
- Normal fields inspected: 124
- FlowFields inspected: 7
- FlowFilters inspected: 1
- `DataClassification` properties added: 123
- Existing `DataClassification` properties normalized: 1
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 50
- Existing captions normalized: 56
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 372
- Remaining noncompliant Normal fields: 6928
- Remaining fields without exact-name Captions: 4787
- Last processed table: 34002510 "Clinetes TPV"

### Batch 15

- Tables inspected: 10 (34002511, 34002512, 34002513, 34002514, 34002515, 34002517, 34002518, 34002519, 34002520, 34002521)
- Tables modified: 10
- Normal fields inspected: 83
- FlowFields inspected: 3
- FlowFilters inspected: 0
- `DataClassification` properties added: 83
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 23
- Existing captions normalized: 49
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 362
- Remaining noncompliant Normal fields: 6845
- Remaining fields without exact-name Captions: 4715
- Last processed table: 34002521 "Pagos TPV"

### Batch 16

- Tables inspected: 10 (34002522, 34002523, 34002524, 34002525, 34002526, 34002527, 34002528, 34002529, 34002530, 34002531)
- Tables modified: 10
- Normal fields inspected: 102
- FlowFields inspected: 9
- FlowFilters inspected: 0
- `DataClassification` properties added: 102
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 17
- Existing captions normalized: 60
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 352
- Remaining noncompliant Normal fields: 6743
- Remaining fields without exact-name Captions: 4638
- Last processed table: 34002531 "Divisas DsPOS"

### Batch 17

- Tables inspected: 10 (34002532, 34002533, 34002534, 34002535, 34002536, 34002537, 34003000, 34003001, 34003002, 34003003)
- Tables modified: 10
- Normal fields inspected: 89
- FlowFields inspected: 6
- FlowFilters inspected: 0
- `DataClassification` properties added: 89
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 70
- Existing captions normalized: 23
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 342
- Remaining noncompliant Normal fields: 6654
- Remaining fields without exact-name Captions: 4545
- Last processed table: 34003003 "Historico Retencion Prov."

### Batch 18

- Tables inspected: 10 (34003004, 34003005, 34003006, 34003007, 34003008, 34003009, 34003010, 34003011, 34003012, 34003013)
- Tables modified: 10
- Normal fields inspected: 91
- FlowFields inspected: 43
- FlowFilters inspected: 0
- `DataClassification` properties added: 88
- Existing `DataClassification` properties normalized: 3
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 44
- Existing captions normalized: 81
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 332
- Remaining noncompliant Normal fields: 6563
- Remaining fields without exact-name Captions: 4420
- Last processed table: 34003013 "Tipos de ingresos"

### Batch 19

- Tables inspected: 10 (34003014, 34003020, 34003021, 34003022, 34003023, 34003024, 34003050, 34003051, 34003052, 34003053)
- Tables modified: 10
- Normal fields inspected: 59
- FlowFields inspected: 2
- FlowFilters inspected: 1
- `DataClassification` properties added: 47
- Existing `DataClassification` properties normalized: 12
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 36
- Existing captions normalized: 22
- Compilation baseline errors: 395
- Current compilation errors: 394
- New errors introduced by this task: 0
- Remaining table objects: 322
- Remaining noncompliant Normal fields: 6504
- Remaining fields without exact-name Captions: 4362
- Last processed table: 34003053 "_Dimensiones POS"

### Batch 20

- Tables inspected: 10 (55000, 55001, 55002, 55003, 55004, 55005, 55006, 55007, 55008, 55009)
- Tables modified: 10
- Normal fields inspected: 163
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 162
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 143
- Existing captions normalized: 7
- Compilation baseline errors: 395
- Current compilation errors: 392
- New errors introduced by this task: 0
- Remaining table objects: 312
- Remaining noncompliant Normal fields: 6342
- Remaining fields without exact-name Captions: 4212
- Last processed table: 55009 "Facturas POS no liquidadas"

### Batch 21

- Tables inspected: 10 (55010, 55012, 55015, 55016, 55017, 55018, 55019, 55025, 55026, 55027)
- Tables modified: 10
- Normal fields inspected: 252
- FlowFields inspected: 3
- FlowFilters inspected: 0
- `DataClassification` properties added: 232
- Existing `DataClassification` properties normalized: 18
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 48
- Existing captions normalized: 5
- Compilation baseline errors: 395
- Current compilation errors: 392
- New errors introduced by this task: 0
- Remaining table objects: 302
- Remaining noncompliant Normal fields: 6090
- Remaining fields without exact-name Captions: 4159
- Last processed table: 55027 TempImpuestoFE

### Batch 22

- Tables inspected: 10 (55028, 55029, 55030, 55040, 55041, 55050, 55100, 55101, 55109, 55110)
- Tables modified: 10
- Normal fields inspected: 225
- FlowFields inspected: 3
- FlowFilters inspected: 0
- `DataClassification` properties added: 186
- Existing `DataClassification` properties normalized: 39
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 72
- Existing captions normalized: 41
- Compilation baseline errors: 395
- Current compilation errors: 392
- New errors introduced by this task: 0
- Remaining table objects: 292
- Remaining noncompliant Normal fields: 5865
- Remaining fields without exact-name Captions: 4046
- Last processed table: 55110 "Conf. Medios de pagos"

### Batch 23

- Tables inspected: 10 (55198, 55111, 55112, 55113, 55129, 55133, 55134, 55135, 55136, 55157)
- Tables modified: 10
- Normal fields inspected: 142
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 46
- Existing `DataClassification` properties normalized: 96
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 141
- Existing captions normalized: 0
- Compilation baseline errors: 395
- Current compilation errors: 392
- New errors introduced by this task: 0
- Remaining table objects: 282
- Remaining noncompliant Normal fields: 5723
- Remaining fields without exact-name Captions: 3905
- Last processed table: 55157 "Ubicaciones que no existen"

### Batch 24

- Tables inspected: 10 (55159, 55160, 55162, 55164, 55170, 55171, 55172, 55173, 55174, 55175)
- Tables modified: 10
- Normal fields inspected: 234
- FlowFields inspected: 7
- FlowFilters inspected: 0
- `DataClassification` properties added: 234
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 29
- Existing captions normalized: 69
- Compilation baseline errors: 395
- Current compilation errors: 392
- New errors introduced by this task: 0
- Remaining table objects: 272
- Remaining noncompliant Normal fields: 5489
- Remaining fields without exact-name Captions: 3807
- Last processed table: 55175 "Vendedores por Colegio"

### Batch 25

- Tables inspected: 10 (55176, 55177, 55178, 55199, 55200, 55201, 55212, 55225, 55226, 55227)
- Tables modified: 10
- Normal fields inspected: 233
- FlowFields inspected: 1
- FlowFilters inspected: 0
- `DataClassification` properties added: 206
- Existing `DataClassification` properties normalized: 27
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 119
- Existing captions normalized: 106
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 262
- Remaining noncompliant Normal fields: 5256
- Remaining fields without exact-name Captions: 3582
- Last processed table: 55227 "Config. Max. Lineas Reportes"

### Batch 26

- Tables inspected: 10 (55228, 55229, 55230, 55231, 55232, 55233, 55234, 55235, 55236, 55237)
- Tables modified: 10
- Normal fields inspected: 100
- FlowFields inspected: 6
- FlowFilters inspected: 0
- `DataClassification` properties added: 100
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 18
- Existing captions normalized: 13
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 252
- Remaining noncompliant Normal fields: 5156
- Remaining fields without exact-name Captions: 3551
- Last processed table: 55237 "Lin. Consig. Dev.Transfer Line"

### Batch 27

- Tables inspected: 10 (55238, 55239, 55240, 55241, 55242, 55243, 55244, 55245, 55246, 55247)
- Tables modified: 10
- Normal fields inspected: 120
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 119
- Existing `DataClassification` properties normalized: 1
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 27
- Existing captions normalized: 79
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 242
- Remaining noncompliant Normal fields: 5036
- Remaining fields without exact-name Captions: 3445
- Last processed table: 55247 "Cab. Hoja de Ruta Reg."

### Batch 28

- Tables inspected: 10 (55248, 55249, 55250, 55251, 55252, 55253, 55254, 55255, 55256, 55257)
- Tables modified: 10
- Normal fields inspected: 126
- FlowFields inspected: 9
- FlowFilters inspected: 3
- `DataClassification` properties added: 125
- Existing `DataClassification` properties normalized: 1
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 26
- Existing captions normalized: 74
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 232
- Remaining noncompliant Normal fields: 4910
- Remaining fields without exact-name Captions: 3345
- Last processed table: 55257 "Contenido Cajas Packing"

### Batch 29

- Tables inspected: 10 (55258, 55259, 55260, 55261, 55262, 55263, 55266, 55267, 55271, 55274)
- Tables modified: 10
- Normal fields inspected: 447
- FlowFields inspected: 22
- FlowFilters inspected: 2
- `DataClassification` properties added: 447
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 55
- Existing captions normalized: 121
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 222
- Remaining noncompliant Normal fields: 4463
- Remaining fields without exact-name Captions: 3169
- Last processed table: 55274 "Order Tracking buffer"

### Batch 30

- Tables inspected: 10 (55279, 55280, 55281, 55290, 55291, 55306, 55310, 55320, 55321, 55322)
- Tables modified: 10
- Normal fields inspected: 86
- FlowFields inspected: 3
- FlowFilters inspected: 0
- `DataClassification` properties added: 49
- Existing `DataClassification` properties normalized: 37
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 80
- Existing captions normalized: 9
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 212
- Remaining noncompliant Normal fields: 4377
- Remaining fields without exact-name Captions: 3080
- Last processed table: 55322 "Log errores revision contratos"

### Batch 31

- Tables inspected: 10 (55353, 55354, 55355, 55442, 55443, 55444, 55445, 55446, 55447, 55448)
- Tables modified: 10
- Normal fields inspected: 207
- FlowFields inspected: 6
- FlowFilters inspected: 0
- `DataClassification` properties added: 207
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 169
- Existing captions normalized: 9
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 202
- Remaining noncompliant Normal fields: 4170
- Remaining fields without exact-name Captions: 2902
- Last processed table: 55448 EXCCRIDatabase

### Batch 32

- Tables inspected: 10 (55449, 55450, 55451, 55452, 55453, 55454, 55455, 55456, 55457, 55458)
- Tables modified: 10
- Normal fields inspected: 86
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 86
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 86
- Existing captions normalized: 0
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 192
- Remaining noncompliant Normal fields: 4084
- Remaining fields without exact-name Captions: 2816
- Last processed table: 55458 Scheduler

### Batch 33

- Tables inspected: 10 (55459, 55460, 55461, 55462, 55463, 55464, 55465, 55467, 55468, 55469)
- Tables modified: 10
- Normal fields inspected: 172
- FlowFields inspected: 2
- FlowFilters inspected: 10
- `DataClassification` properties added: 172
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 110
- Existing captions normalized: 24
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 182
- Remaining noncompliant Normal fields: 3912
- Remaining fields without exact-name Captions: 2682
- Last processed table: 55469 "Datos auxiliares"

### Batch 34

- Tables inspected: 10 (55470, 55471, 55472, 55473, 55474, 55475, 55476, 55477, 55478, 55479)
- Tables modified: 10
- Normal fields inspected: 91
- FlowFields inspected: 8
- FlowFilters inspected: 4
- `DataClassification` properties added: 91
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 74
- Existing captions normalized: 14
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 172
- Remaining noncompliant Normal fields: 3821
- Remaining fields without exact-name Captions: 2594
- Last processed table: 55479 Talleres

### Batch 35

- Tables inspected: 10 (55480, 55481, 55482, 55483, 55484, 55485, 55486, 55487, 55488, 55489)
- Tables modified: 10
- Normal fields inspected: 235
- FlowFields inspected: 10
- FlowFilters inspected: 1
- `DataClassification` properties added: 235
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 131
- Existing captions normalized: 64
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 162
- Remaining noncompliant Normal fields: 3586
- Remaining fields without exact-name Captions: 2399
- Last processed table: 55489 "Nivel Educativo APS"

### Batch 36

- Tables inspected: 10 (55490, 55491, 55492, 55493, 55494, 55495, 55496, 55497, 55498, 55499)
- Tables modified: 10
- Normal fields inspected: 122
- FlowFields inspected: 8
- FlowFilters inspected: 1
- `DataClassification` properties added: 122
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 109
- Existing captions normalized: 10
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 152
- Remaining noncompliant Normal fields: 3464
- Remaining fields without exact-name Captions: 2280
- Last processed table: 55499 "FlagsInRepeater Bitmaps"

### Batch 37

- Tables inspected: 10 (55500, 55501, 55502, 55503, 55504, 55505, 55506, 55507, 55508, 55509)
- Tables modified: 10
- Normal fields inspected: 187
- FlowFields inspected: 24
- FlowFilters inspected: 0
- `DataClassification` properties added: 186
- Existing `DataClassification` properties normalized: 1
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 149
- Existing captions normalized: 22
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 142
- Remaining noncompliant Normal fields: 3277
- Remaining fields without exact-name Captions: 2109
- Last processed table: 55509 "Datos Colegio - Asignatura"

### Batch 38

- Tables inspected: 10 (55510, 55511, 55512, 55513, 55514, 55515, 55516, 55517, 55518, 55519)
- Tables modified: 10
- Normal fields inspected: 112
- FlowFields inspected: 15
- FlowFilters inspected: 1
- `DataClassification` properties added: 112
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 109
- Existing captions normalized: 16
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 132
- Remaining noncompliant Normal fields: 3165
- Remaining fields without exact-name Captions: 1984
- Last processed table: 55519 "Colegio - Adopciones Cab"

### Batch 39

- Tables inspected: 10 (55520, 55521, 55522, 55523, 55524, 55525, 55526, 55527, 55528, 55529)
- Tables modified: 10
- Normal fields inspected: 345
- FlowFields inspected: 18
- FlowFilters inspected: 2
- `DataClassification` properties added: 345
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 251
- Existing captions normalized: 72
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 122
- Remaining noncompliant Normal fields: 2820
- Remaining fields without exact-name Captions: 1661
- Last processed table: 55529 "Colegio - Work Flow visitas"

### Batch 40

- Tables inspected: 10 (55530, 55531, 55532, 55533, 55534, 55535, 55536, 55537, 55538, 55539)
- Tables modified: 10
- Normal fields inspected: 231
- FlowFields inspected: 24
- FlowFilters inspected: 16
- `DataClassification` properties added: 231
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 124
- Existing captions normalized: 25
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 112
- Remaining noncompliant Normal fields: 2589
- Remaining fields without exact-name Captions: 1512
- Last processed table: 55539 "Historico Docentes - CDS"

### Batch 41

- Tables inspected: 10 (55540, 55541, 55542, 55543, 55544, 55545, 55546, 55547, 55548, 55644)
- Tables modified: 10
- Normal fields inspected: 82
- FlowFields inspected: 5
- FlowFilters inspected: 0
- `DataClassification` properties added: 82
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 69
- Existing captions normalized: 16
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 102
- Remaining noncompliant Normal fields: 2507
- Remaining fields without exact-name Captions: 1427
- Last processed table: 55644 "Solicitud -  Especialidad Asi."

### Batch 42

- Tables inspected: 10 (55645, 55646, 55647, 55648, 55649, 55650, 55651, 55549, 55550, 55551)
- Tables modified: 10
- Normal fields inspected: 85
- FlowFields inspected: 5
- FlowFilters inspected: 1
- `DataClassification` properties added: 85
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 86
- Existing captions normalized: 5
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 92
- Remaining noncompliant Normal fields: 2422
- Remaining fields without exact-name Captions: 1336
- Last processed table: 55551 "Ranking CVM Colegio"

### Batch 43

- Tables inspected: 10 (55552, 55553, 55554, 55555, 55556, 55557, 55558, 55559, 55560, 55561)
- Tables modified: 10
- Normal fields inspected: 174
- FlowFields inspected: 6
- FlowFilters inspected: 0
- `DataClassification` properties added: 174
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 176
- Existing captions normalized: 2
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 82
- Remaining noncompliant Normal fields: 2248
- Remaining fields without exact-name Captions: 1158
- Last processed table: 55561 "Cab. Visita Asesor/Consultor"

### Batch 44

- Tables inspected: 10 (55562, 55563, 55564, 55565, 55566, 55567, 55568, 55569, 55570, 55571)
- Tables modified: 10
- Normal fields inspected: 226
- FlowFields inspected: 2
- FlowFilters inspected: 0
- `DataClassification` properties added: 226
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 221
- Existing captions normalized: 2
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 72
- Remaining noncompliant Normal fields: 2022
- Remaining fields without exact-name Captions: 935
- Last processed table: 55571 "Tabla trabajo Calculo CVM"

### Batch 45

- Tables inspected: 10 (55572, 55573, 55574, 55575, 55576, 55577, 55578, 55579, 70000, 70001)
- Tables modified: 10
- Normal fields inspected: 319
- FlowFields inspected: 9
- FlowFilters inspected: 0
- `DataClassification` properties added: 319
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 324
- Existing captions normalized: 0
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 62
- Remaining noncompliant Normal fields: 1703
- Remaining fields without exact-name Captions: 611
- Last processed table: 70001 "Autor comercial GL024"

### Batch 46

- Tables inspected: 10 (70002, 70003, 70004, 70005, 70006, 70007, 70008, 70009, 70010, 70020)
- Tables modified: 10
- Normal fields inspected: 88
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 88
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 88
- Existing captions normalized: 0
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 52
- Remaining noncompliant Normal fields: 1615
- Remaining fields without exact-name Captions: 523
- Last processed table: 70020 "Plantilla Queen Mat. Comerc.1"

### Batch 47

- Tables inspected: 10 (70500, 70501, 70502, 70503, 70504, 70505, 70506, 70507, 70508, 70509)
- Tables modified: 10
- Normal fields inspected: 100
- FlowFields inspected: 0
- FlowFilters inspected: 0
- `DataClassification` properties added: 100
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 99
- Existing captions normalized: 1
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 42
- Remaining noncompliant Normal fields: 1515
- Remaining fields without exact-name Captions: 423
- Last processed table: 70509 GL004

### Batch 48

- Tables inspected: 10 (70510, 70511, 70512, 70513, 70514, 70515, 75000, 75001, 75002, 75003)
- Tables modified: 10
- Normal fields inspected: 91
- FlowFields inspected: 2
- FlowFilters inspected: 0
- `DataClassification` properties added: 91
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 50
- Existing captions normalized: 13
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 32
- Remaining noncompliant Normal fields: 1424
- Remaining fields without exact-name Captions: 360
- Last processed table: 75003 "Imp.MdM Cabecera"

### Batch 49

- Tables inspected: 10 (75004, 75005, 75006, 75007, 75008, 75009, 75010, 75011, 75012, 75013)
- Tables modified: 10
- Normal fields inspected: 66
- FlowFields inspected: 4
- FlowFilters inspected: 2
- `DataClassification` properties added: 66
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 51
- Existing captions normalized: 9
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 22
- Remaining noncompliant Normal fields: 1358
- Remaining fields without exact-name Captions: 300
- Last processed table: 75013 "Filtro Campo Buffer"

### Batch 50

- Tables inspected: 10 (75014, 75015, 75016, 80000, 80001, 80002, 80003, 80004, 80005, 80006)
- Tables modified: 10
- Normal fields inspected: 668
- FlowFields inspected: 16
- FlowFilters inspected: 0
- `DataClassification` properties added: 668
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 42
- Existing captions normalized: 112
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 12
- Remaining noncompliant Normal fields: 690
- Remaining fields without exact-name Captions: 146
- Last processed table: 80006 "Tmp Purch. Inv. Line"

### Batch 51

- Tables inspected: 10 (80007, 80008, 80009, 80010, 80011, 80012, 80013, 80014, 80015, 86000)
- Tables modified: 10
- Normal fields inspected: 649
- FlowFields inspected: 21
- FlowFilters inspected: 2
- `DataClassification` properties added: 649
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 40
- Existing captions normalized: 95
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 2
- Remaining noncompliant Normal fields: 41
- Remaining fields without exact-name Captions: 11
- Last processed table: 86000 "Tmp productos a devolver"

### Batch 52

- Tables inspected: 2 (86001, 90000)
- Tables modified: 2
- Normal fields inspected: 41
- FlowFields inspected: 15
- FlowFilters inspected: 5
- `DataClassification` properties added: 41
- Existing `DataClassification` properties normalized: 0
- Invalid FlowField or FlowFilter classifications removed: 0
- Captions added: 6
- Existing captions normalized: 5
- Compilation baseline errors: 395
- Current compilation errors: 391
- New errors introduced by this task: 0
- Remaining table objects: 0
- Remaining noncompliant Normal fields: 0
- Remaining fields without exact-name Captions: 0
- Last processed table: 90000 "G/L Account2"

## Final verification

- Verification date: 2026-07-29
- Total table objects verified: 512
- Total fields verified: 9,085
- Normal fields: 8,620
- FlowFields: 407
- FlowFilters: 58
- Noncompliant Normal fields: 0
- FlowFields or FlowFilters containing `DataClassification`: 0
- Fields without an exact-name Caption: 0
- Duplicate `DataClassification` properties: 0
- Duplicate `Caption` properties: 0
- Table extensions modified: 0
- Previous-task tables processed and rechecked: 30
- Additional tables processed in this continuation: 482
- Continuation compilation batches: 49
- Continuation Normal fields inspected: 8,313
- Continuation FlowFields inspected: 403
- Continuation FlowFilters inspected: 58
- Continuation Normal fields normalized: 8,312
- Continuation `DataClassification` properties added: 7,594
- Continuation existing `DataClassification` properties normalized: 716
- Continuation invalid virtual-field classifications removed: 0
- Continuation Captions added: 4,100
- Continuation existing Captions normalized: 1,828
- Baseline compilation errors: 395
- Final compilation errors: 391
- Final scoped errors under `src/tables`: 0
- New errors introduced by this continuation: 0
- Final warnings reported: At least 500 pre-existing warnings; the diagnostic list was truncated at 500.
- Exact stop condition: Every table field is compliant with the corrected compiler-compatible metadata rules, and the task introduced no new compilation errors.
