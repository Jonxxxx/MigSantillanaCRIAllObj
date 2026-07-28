# Codeunit Migration TODO Audit

## Current-source baseline

- Inventory date: 2026-07-28.
- AL files under `src/Codeunits`: 138.
- AL files containing `//TODO: Ver`: 54.
- Current `//TODO: Ver` occurrences: 356.
- Existing `// TODO: Manual review` occurrences: 0.
- Candidate source of truth: current `.al` files, not this audit.
- Classification status: initial heuristic grouping only. Every candidate must
  be re-evaluated against its complete current codeunit, repository objects,
  Business Central v27 symbols, public callers, and compilation results.

## Initial pattern grouping

| Pattern | Current markers |
|---|---:|
| Deterministic syntax or field/enum change | 9 |
| Renamed or obsolete standard API | 8 |
| Changed procedure signature | 3 |
| Changed/custom object, table, field, or method dependency | 38 |
| Event subscriber | 0 |
| Posting or financial logic | 13 |
| No. Series | 7 |
| Dimensions | 3 |
| Temporary records or posting buffers | 1 |
| File handling or Windows/server-file dependency | 141 |
| Email | 21 |
| HttpClient or external integration | 5 |
| DotNet, Automation, ADO, or direct SQL | 9 |
| Large commented block or functional ambiguity | 6 |
| Other, requiring procedure-level reclassification | 91 |
| **Total** | **356** |

The initial grouping is deliberately conservative. In particular, many
markers classified as `Other` occur inside large payment-export, posting,
integration, or disabled-code blocks and must be reclassified as a logical
block during processing.

## Current markers by codeunit

| Codeunit file | Markers |
|---|---:|
| Codeunit 130410 - Sys. Warmup Test Runner.al | 1 |
| Codeunit 34002102 - Anular nómina.al | 2 |
| Codeunit 34002104 - Funciones Nomina.al | 4 |
| Codeunit 34002108 - Imprime en PDF.al | 9 |
| Codeunit 34002111 - Registrar nomina CR.al | 2 |
| Codeunit 34002112 - Registrar nomina PA.al | 2 |
| Codeunit 34002114 - Registrar nomina HN.al | 2 |
| Codeunit 34002115 - Registrar nomina PY.al | 2 |
| Codeunit 34002118 - Registrar nomina RD.al | 6 |
| Codeunit 34002119 - Registrar nomina RD -2.al | 2 |
| Codeunit 34002124 - ADO Connection Mgmt.al | 1 |
| Codeunit 34002125 - Genera Formatos E. Nomina RD.al | 106 |
| Codeunit 34002126 - Genera Formatos E. Nomina CR.al | 30 |
| Codeunit 34002135 - Genera formatos elect. legales.al | 41 |
| Codeunit 34002145 - Funciones entrenamientos.al | 7 |
| Codeunit 34002160 - Registrar nomina CR New.al | 2 |
| Codeunit 34002199 - Utilitario para corr. datos no.al | 7 |
| Codeunit 34002500 - Lanzador DsPOS.al | 2 |
| Codeunit 34002520 - Facturas Registradas POS.al | 1 |
| Codeunit 34002521 - Control TPV.al | 1 |
| Codeunit 34002522 - Registrar Ventas en Lote DsPOS.al | 12 |
| Codeunit 34002523 - Notas Crédito Regis POS.al | 1 |
| Codeunit 34002524 - Facturas Pendientes POS.al | 1 |
| Codeunit 34002525 - Notas Crédito Pdtes POS.al | 1 |
| Codeunit 50010 - CI_AnularFacturas.al | 2 |
| Codeunit 50112 - Registra Pedidos Vta. SIC_BC.al | 1 |
| Codeunit 50113 - Sales-Post + Print SIC_BC.al | 4 |
| Codeunit 50300 - Notificar Errores Colas.al | 5 |
| Codeunit 52502 - Utilitario para corregir cosas.al | 10 |
| Codeunit 52504 - Facturacion Electronica NAV.al | 1 |
| Codeunit 52506 - Registro de costo.al | 1 |
| Codeunit 55002 - Export Payments Formato EC.al | 6 |
| Codeunit 56000 - Funciones Santillana.al | 2 |
| Codeunit 56003 - Factura Electronica.al | 1 |
| Codeunit 56008 - Registro de costos.al | 1 |
| Codeunit 56050 - Clasificacion devoluciones.al | 1 |
| Codeunit 56051 - Cancelar reservas Call Center.al | 1 |
| Codeunit 56200 - Web Service MdE.al | 5 |
| Codeunit 56201 - Informacion Complementaria MDE.al | 1 |
| Codeunit 56202 - MdE Management.al | 3 |
| Codeunit 56206 - Aplicar cambios MdE via Job Q.al | 8 |
| Codeunit 56300 - Email packing.al | 4 |
| Codeunit 67001 - Generacion Words APS.al | 1 |
| Codeunit 67002 - Funciones cálculo Ranking.al | 2 |
| Codeunit 75000 - Funciones MdM.al | 15 |
| Codeunit 75001 - Gest. Maestros MdM.al | 2 |
| Codeunit 75002 - Imp Excel MdM.al | 4 |
| Codeunit 75005 - MdM Async Manager.al | 3 |
| Codeunit 75006 - MdM Async Sender.al | 1 |
| Codeunit 75007 - MdM Gen. Prod..al | 4 |
| Codeunit 75009 - MdM Macros.al | 7 |
| EXCCRIGenJnlPostLineSub.Codeunit.al | 6 |
| EXCCRISalesPostYesNoSub.Codeunit.al | 6 |
| EXCCRITableMigrationHandler.Codeunit.al | 2 |

## Final state

- Final `//TODO: Ver` occurrences: 0.
- Final `// TODO: Manual review` comments: 206.
- Original markers safely resolved: 41.
- Original markers converted to manual review: 315.
- Final `al_compile`: succeeded with 0 errors and 10,118 warnings.
- Warnings introduced by this task: 0; the final warning count matches the
  10,118-warning baseline.
