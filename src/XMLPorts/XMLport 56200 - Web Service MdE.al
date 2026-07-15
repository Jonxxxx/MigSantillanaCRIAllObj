xmlport 56200 "Web Service MdE"
{
    // --------------------------------------------------------------------------------
    // -- XMLport automatically created with Dynamics NAV XMLport Generator 1.3.0.2
    // -- Copyright ® 2007-2012 Carsten Scholling
    // --------------------------------------------------------------------------------
    // 
    // #81969 27/01/2018 PLB: Se genera un historial MdE, si la fecha efectiva es hoy, se pasan los datos al empleado, si no se espera a que llegue el dia (se procesa por una tarea programada)

    DefaultNamespace = 'http://prisa.com';
    Direction = Both;
    Encoding = UTF8;
    UseDefaultNamespace = true;

    schema
    {
        textelement(mae)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            XmlName = 'mae';
            textelement(mensaje)
            {
                MaxOccurs = Once;
                MinOccurs = Once;
                XmlName = 'mensaje';
                textelement(head)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;
                    XmlName = 'head';
                    textelement(id_mensaje)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'id_mensaje';
                    }
                    textelement(sistema_origen)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'sistema_origen';
                    }
                    textelement(pais_origen)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'pais_origen';
                    }
                    textelement(fecha_origen)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'fecha_origen';
                    }
                    textelement(fecha)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'fecha';
                    }
                    textelement(tipo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'tipo';
                    }
                }
                textelement(body)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;
                    XmlName = 'body';
                    textelement(operacion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Operacion';
                    }
                    textelement(numero_persona)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Numero_persona';
                    }
                    textelement(numero_persona_sistema_loca)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Numero_persona_sistema_local_hr';
                    }
                    textelement(m_fecha_inicio_contrato)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_inicio_contrato';
                    }
                    textelement(fecha_inicio_contrato)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Fecha_inicio_contrato';
                    }
                    textelement(m_fecha_fin_contrato)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_fin_contrato';
                    }
                    textelement(fecha_fin_contrato)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Fecha_fin_contrato';
                    }
                    textelement(m_fecha_antiguedad_reconoci)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_antiguedad_reconocida';
                    }
                    textelement(fecha_antiguedad_reconocida)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Fecha_antiguedad_reconocida';
                    }
                    textelement(m_fecha_efectiva)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_efectiva';
                    }
                    textelement(fecha_efectiva)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Fecha_efectiva';
                    }
                    textelement(m_motivo_contratacion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_motivo_contratacion';
                    }
                    textelement(motivo_contratacion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Motivo_contratacion';
                    }
                    textelement(m_tipo_baja)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tipo_baja';
                    }
                    textelement(tipo_baja)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Tipo_baja';
                    }
                    textelement(m_destino_empleado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_destino_empleado';
                    }
                    textelement(destino_empleado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Destino_empleado';
                    }
                    textelement(m_tipo_documento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tipo_documento';
                    }
                    textelement(tipo_documento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Tipo_documento';
                    }
                    textelement(m_numero_documento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_numero_documento';
                    }
                    textelement(numero_documento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Numero_documento';
                    }
                    textelement(m_tratamiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tratamiento';
                    }
                    textelement(tratamiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Tratamiento';
                    }
                    textelement(m_nombre)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_nombre';
                    }
                    textelement(nombre)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Nombre';
                    }
                    textelement(m_nombre_preferido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_nombre_preferido';
                    }
                    textelement(nombre_preferido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Nombre_preferido';
                    }
                    textelement(m_primer_apellido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_primer_apellido';
                    }
                    textelement(primer_apellido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Primer_apellido';
                    }
                    textelement(m_segundo_apellido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_segundo_apellido';
                    }
                    textelement(segundo_apellido)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Segundo_apellido';
                    }
                    textelement(m_genero)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_genero';
                    }
                    textelement(genero)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Genero';
                    }
                    textelement(m_estado_civil)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_estado_civil';
                    }
                    textelement(estado_civil)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Estado_civil';
                    }
                    textelement(m_discapacidad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_discapacidad';
                    }
                    textelement(discapacidad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Discapacidad';
                    }
                    textelement(m_fecha_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_nacimiento';
                    }
                    textelement(fecha_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Fecha_nacimiento';
                    }
                    textelement(m_provincia_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_provincia_nacimiento';
                    }
                    textelement(provincia_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Provincia_nacimiento';
                    }
                    textelement(m_pais_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_pais_nacimiento';
                    }
                    textelement(pais_nacimiento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Pais_nacimiento';
                    }
                    textelement(m_nacionalidad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_nacionalidad';
                    }
                    textelement(nacionalidad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Nacionalidad';
                    }
                    textelement(m_pais)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_pais';
                    }
                    textelement(pais)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Pais';
                    }
                    textelement(m_tipo_calle)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tipo_calle';
                    }
                    textelement(tipo_calle)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Tipo_calle';
                    }
                    textelement(m_nombre_calle)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_nombre_calle';
                    }
                    textelement(nombre_calle)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Nombre_calle';
                    }
                    textelement(m_numero)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_numero';
                    }
                    textelement(numero)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Numero';
                    }
                    textelement(m_adicional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_adicional';
                    }
                    textelement(adicional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Adicional';
                    }
                    textelement(m_codigo_postal)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_codigo_postal';
                    }
                    textelement(codigo_postal)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Codigo_postal';
                    }
                    textelement(m_ciudad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_ciudad';
                    }
                    textelement(ciudad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Ciudad';
                    }
                    textelement(m_provincia)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_provincia';
                    }
                    textelement(provincia)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Provincia';
                    }
                    textelement(m_direccion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_direccion';
                    }
                    textelement(direccion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Direccion';
                    }
                    textelement(m_numero_telefono)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_numero_telefono';
                    }
                    textelement(numero_telefono)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Numero_telefono';
                    }
                    textelement(m_extension)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_extension';
                    }
                    textelement(extension)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Extension';
                    }
                    textelement(m_posicion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_posicion';
                    }
                    textelement(posicion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Posicion';
                    }
                    textelement(m_fecha_entrada_posicion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_fecha_entrada_posicion';
                    }
                    textelement(fecha_entrada_posicion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Fecha_entrada_posicion';
                    }
                    textelement(m_unidad_negocio)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_unidad_negocio';
                    }
                    textelement(unidad_negocio)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Unidad_negocio';
                    }
                    textelement(m_zona_geografica)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_zona_geografica';
                    }
                    textelement(zona_geografica)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Zona_geografica';
                    }
                    textelement(m_pais_puesto)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_pais_puesto';
                    }
                    textelement(pais_puesto)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Pais_puesto';
                    }
                    textelement(m_division)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_division';
                    }
                    textelement(division)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Division';
                    }
                    textelement(m_sociedad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_sociedad';
                    }
                    textelement(sociedad)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Sociedad';
                    }
                    textelement(m_centro_trabajo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_centro_trabajo';
                    }
                    textelement(centro_trabajo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        XmlName = 'Centro_trabajo';
                    }
                    textelement(m_area_funcional_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_area_funcional_grupo';
                    }
                    textelement(area_funcional_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Area_funcional_grupo';
                    }
                    textelement(m_departamento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_departamento';
                    }
                    textelement(departamento)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Departamento';
                    }
                    textelement(m_departamento_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_departamento_grupo';
                    }
                    textelement(departamento_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Departamento_grupo';
                    }
                    textelement(m_producto_programa)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_producto_programa';
                    }
                    textelement(producto_programa)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Producto_programa';
                    }
                    textelement(m_categoria_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_Categoria_grupo';
                    }
                    textelement(categoria_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Categoria_grupo';
                    }
                    textelement(m_tipo_contrato_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tipo_contrato_grupo';
                    }
                    textelement(tipo_contrato_grupo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Tipo_contrato_grupo';
                    }
                    textelement(m_tipo_empleado_prisa)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_tipo_empleado_prisa';
                    }
                    textelement(tipo_empleado_prisa)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Tipo_empleado_prisa';
                    }
                    textelement(m_ambito_regional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_ambito_regional';
                    }
                    textelement(ambito_regional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Ambito_regional';
                    }
                    textelement(m_global)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_global';
                    }
                    textelement(global)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Global';
                    }
                    textelement(m_coorporativo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_coorporativo';
                    }
                    textelement(coorporativo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Coorporativo';
                    }
                    textelement(m_motivo_contratacion_siste)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_motivo_contratacion_sistema_local_hr';
                    }
                    textelement(motivo_contratacion_sistema)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Motivo_contratacion_sistema_local_hr';
                    }
                    textelement(m_motivo_terminacion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_motivo_terminacion';
                    }
                    textelement(motivo_terminacion)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Motivo_terminacion';
                    }
                    textelement(m_procedencia_empleado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_procedencia_empleado';
                    }
                    textelement(procedencia_empleado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Procedencia_empleado';
                    }
                    textelement(m_expatriado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_expatriado';
                    }
                    textelement(expatriado)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Expatriado';
                    }
                    textelement(m_representante_trabajadore)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_representante_trabajadores';
                    }
                    textelement(representante_trabajadores)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Representante_trabajadores';
                    }
                    textelement(m_clasificacion_digital)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_clasificacion_digital';
                    }
                    textelement(clasificacion_digital)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Clasificacion_digital';
                    }
                    textelement(m_salario_fijo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_salario_fijo';
                    }
                    textelement(salario_fijo)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Salario_fijo';
                    }
                    textelement(m_posicion_superior)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_posicion_superior';
                    }
                    textelement(posicion_superior)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Posicion_superior';
                    }
                    textelement(m_responsable_funcional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_responsable_funcional';
                    }
                    textelement(responsable_funcional)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Responsable_funcional';
                    }
                    textelement(m_area_funcional_unidad_neg)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'M_area_funcional_unidad_negocio';
                    }
                    textelement(area_funcional_unidad_negoc)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Once;
                        TextType = Text;
                        XmlName = 'Area_funcional_unidad_negocio';
                    }
                    textelement(m_error_interfaz)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        XmlName = 'M_error_interfaz';
                    }
                    textelement(error_interfaz)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        TextType = Text;
                        XmlName = 'Error_interfaz';
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    //TOOD: Ver 
    /*
    trigger OnInitXmlPort()
    begin
        GLOBALLANGUAGE := 2058; // ESM (es-MX)
    end;

    trigger OnPostXmlPort()
    begin
        IF NOT Exporting THEN BEGIN //+#101415
            IF ConfSant."Cod. sociedad maestros Santill" <> Sociedad THEN
                AddError(STRSUBSTNO(ErrorCompanyDoNotMatch, Sociedad, ConfSant."Cod. sociedad maestros Santill"), ErrorTipoConf);

            IF IsOk THEN BEGIN
                CASE Operacion OF
                    'INSERT':
                        CreateEmployee(FALSE);
                    'CHANGE':
                        ModifyEmployee();
                    'DELETE':
                        DeleteEmployee();
                    ELSE
                        AddError(ErrorOperation, ErrorTipoDatos);
                END;
            END;

            //+#101415
            // Enviamos la respuesta elaborada a MdE
            //IF ConfSant."WS Respuesta MdE" <> '' THEN
            //  SendAsyncResponse();
            CreateAsyncResponse();
        END
        ELSE
            Exporting := FALSE;
        //+#101415
    end;

    trigger OnPreXmlPort()
    begin
        // la empresa tiene que tener el cod. sociedad de maestros Santillana definido
        IF NOT Exporting THEN BEGIN //+#101415
            ConfSant.GET;
            IsOk := TRUE;
            CLEAR(EmployeeNo);

            IF ConfSant."Cod. sociedad maestros Santill" = '' THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("Cod. sociedad maestros Santill"), ConfSant.TABLECAPTION), ErrorTipoConf);

            IF ConfSant."Cod. pais maestros Santill" = '' THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("Cod. pais maestros Santill"), ConfSant.TABLECAPTION), ErrorTipoConf);

            IF ConfSant."WS Respuesta MdE" = '' THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("WS Respuesta MdE"), ConfSant.TABLECAPTION), ErrorTipoConf);

            IF (ConfSant."Departamento MdE" = ConfSant."Departamento MdE"::Dimension) AND (ConfSant."Dimension Departamento" = '') THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("Dimension Departamento"), ConfSant.TABLECAPTION), ErrorTipoConf);

            IF (ConfSant."Division MdE" = ConfSant."Division MdE"::Dimension) AND (ConfSant."Dimension Division" = '') THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("Dimension Division"), ConfSant.TABLECAPTION), ErrorTipoConf);

            IF (ConfSant."Area funcional MdE" = ConfSant."Area funcional MdE"::Dimension) AND (ConfSant."Dimension Area funcional" = '') THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, ConfSant.FIELDCAPTION("Dimension Area funcional"), ConfSant.TABLECAPTION), ErrorTipoConf);

            //+#81969
            IF NOT EmpCotiz.FINDFIRST THEN
                AddError(STRSUBSTNO(ErrorCompanyConfig, EmpCotiz.FIELDCAPTION("Empresa cotizacion"), EmpCotiz.TABLECAPTION), ErrorTipoConf);
            //-#81969
        END; //+#101415
    end;

    var
        ConfSant: Record 56001;
        Employee: Record 5200;
        MdEHistory: Record 56202;
        EmpCotiz: Record 34002100;
        MdEMgnt: Codeunit 56202;
        EmployeeNo: Code[20];
        DescErrorArray: array[10] of Text;
        TipoErrorArray: array[10] of Text;
        ErrorEmployeeDoNotExist: Label 'El empleado %1 %2 no existe.';
        ErrorContractDoNotExist: Label 'El contrato para el empleado %1 %2 no existe.';
        ErrorCompanyConfig: Label 'Es necesario definir %1 en %2.';
        ErrorCompanyDoNotMatch: Label 'La informacion de companyia del XML (%1) no coincide con la de la base de datos (%2).';
        ErrorTipoConf: Label 'Error de configuracion';
        ErrorTipoDatos: Label 'Error de datos';
        IsOk: Boolean;
        ErrorOperation: Label 'No se ha recibido un tipo de operacion esperada ("INSERT", "CHANGE" o "DELETE").';
        ErrorTamanoCampo: Label 'El tamaño del valor del nodo %1 (%2) es mayor que el aceptado por el campo "%3" (%4).';
        ErrorTipoVar: Label 'El tipo de dato del nodo %1 (%2) no se ajusta al que necesita el campo "%3".';
        ErrorTipoDatoNoVal: Label 'El campo "%1" no es de un tipo de dato válido.';
        ErrorTablaRel: Label 'El valor del nodo %1 (%2) no existe en la tabla "%3".';
        ErrorEmployeeExist: Label 'Ya existe un empleado (Nº "%1") con Tipo documento "%2" y Nº documento "%3". No se puede crear el empleado "%4".';
        ErrorDimension: Label 'La dimension "%2" se ha configurado para validar el nodo "%1" pero no existe en NAV.';
        ErrorValorDimension: Label 'El valor del nodo %1 (%2) no existe en la tabla en la dimension %3.';
        ErrorFechas: Label 'La fecha inicio (%1) del contrato no puede ser superior a la fecha finalizacion (%2).';
        ErrorRecontratacion: Label 'El empleado "%1" está de baja, parece que está llegando una recontratacion (fecha inicio contrato modificada), pero el "%2" no es de recontratacion ("%3").';
        ErrorContratacion: Label 'Está dando una alta, pero el "%1" no es de nueva contratacion ni recontratacion ("%2").';
        NS: ;
        CodeValue: Code[20];
        DimensionTxt: Label 'Dimension %1';
        ErrorInsert: Label 'No se puede crear el %1 para el empleado %2.';
        ErrorInsertEmployee: Label ' Revise que, si está enviando un alta nueva, el número de serie asignado a recursos humanos en Dynamics NAV esté correctamente configurado.';
        ErrorModify: Label 'No se puede modificar el %1 para el empleado %2.';
        Exporting: Boolean;
        CreateDefaultDim: Boolean;
        ErrorDatoObligatorio: Label 'En la operacion de tipo %1 el valor del nodo %2 es obligatorio y ha llegado en blanco.';

    local procedure CreateEmployee(FromModifyEmployee: Boolean)
    var
        //TOOD: Ver Contrato: Record 34002109;
        Create: Boolean;
        NoOrden: Integer;
        Found: Boolean;
    begin
        //EmpCotiz.FINDFIRST; //-#81969

        Create := IsNewContract();

        IF NOT Create AND NOT IsRecontratacion() THEN BEGIN
            AddError(STRSUBSTNO(ErrorContratacion, 'Motivo_contratacion_sistema_local', Motivo_contratacion_sistema), ErrorTipoDatos);
            EXIT;
        END;

        IF NOT FromModifyEmployee THEN BEGIN
            IF LocalizarEmpleadoError(Create) THEN
                EXIT;
            Employee.RESET;
        END;

        

        CreateDefaultDim := FALSE;
        UpdateMdEHistory;
        CreateDefaultDim := TRUE;

        IF NOT IsOk THEN
            EXIT;

        IF NOT Create AND (MdEHistory."Fecha efectiva" > TODAY) THEN BEGIN
            EmployeeNo := Employee."No.";
            MdEHistory."No." := Employee."No.";
            MdEHistory.INSERT(TRUE);
            EXIT;
        END;

        MdEHistory.InsertEmployee(Employee);
        IsOk := MdEHistory.GetErrors(DescErrorArray, TipoErrorArray);

        EmployeeNo := Employee."No.";
        //-#81969

    end;

    local procedure ModifyEmployee()
    var
        //TOOD: Ver Contrato: Record 34002109;
        Found: Boolean;
        Recontratacion: Boolean;
    begin

        IF LocalizarEmpleadoError(FALSE) THEN
            EXIT;

        Employee.RESET;

        // Cuando recibimos un UPDATE y el empleado está de baja (o no hay linea de contrato) se entiende que es
        // una recontratacion, si el motivo es una alta nueva, daremos el correspondiente error
        
        Contrato.SETRANGE("No. empleado", EmployeeNo);
        Recontratacion := NOT Contrato.FIND('+');
        IF NOT Recontratacion AND (Contrato."Fecha finalizacion" <> 0D) THEN
            Recontratacion := TRUE;
        IF Recontratacion THEN BEGIN
            IF IsNewContract() OR NOT IsRecontratacion() THEN
                AddError(STRSUBSTNO(ErrorRecontratacion, EmployeeNo, 'Motivo_contratacion_sistema_local', Motivo_contratacion_sistema), ErrorTipoDatos)
            ELSE
                CreateEmployee(TRUE);
            EXIT;
        END;
       

        
        CreateDefaultDim := FALSE;
        UpdateMdEHistory;
        CreateDefaultDim := TRUE;

        IF NOT IsOk THEN
            EXIT;

        IF MdEHistory."Fecha efectiva" > TODAY THEN BEGIN
            MdEHistory."No." := Employee."No.";
            MdEHistory.INSERT(TRUE);
            EXIT;
        END;

        //TOOD: Ver MdEHistory.ModifyEmployee(Employee);
        IsOk := MdEHistory.GetErrors(DescErrorArray, TipoErrorArray);
        //-#81969

    end;

    local procedure DeleteEmployee()
    var
        //TOOD: Ver Contrato: Record 34002109;
    begin
        EmployeeNo := Numero_persona_sistema_loca;
        IF NOT Employee.GET(EmployeeNo) THEN BEGIN
            //TOOD: Ver Employee.SETRANGE("Numero de persona", Numero_persona);
            IF NOT Employee.FIND('-') THEN BEGIN
                AddError(STRSUBSTNO(ErrorEmployeeDoNotExist, 'Numero_persona', Numero_persona), ErrorTipoDatos);
                EXIT;
            END;
            EmployeeNo := Employee."No.";
        END;

        
        CreateDefaultDim := FALSE;
        UpdateMdEHistory;
        CreateDefaultDim := TRUE;

        IF NOT IsOk THEN
            EXIT;

        IF MdEHistory."Fecha efectiva" > TODAY THEN BEGIN
            MdEHistory."No." := Employee."No.";
            MdEHistory.INSERT(TRUE);
            EXIT;
        END;

        //TOOD: Ver MdEHistory.DeleteEmployee(Employee);
        IsOk := MdEHistory.GetErrors(DescErrorArray, TipoErrorArray);
        //-#81969

    end;

    local procedure Modified(Value: Text[30]): Boolean
    begin
        EXIT(Value = 'X');
    end;

    local procedure GetEstado(IsOk: Boolean): Text
    begin
        //5: Failed, 4: Successful, 2: Pending
        IF IsOk THEN
            EXIT('4')
        ELSE
            EXIT('5');
    end;

    local procedure AddError(ErrorText: Text; ErrorType: Text)
    var
        i: Integer;
        added: Boolean;
    begin
        IF IsOk THEN
            IsOk := FALSE;

        added := FALSE;
        i := 0;
        REPEAT
            i += 1;
            IF DescErrorArray[i] = '' THEN BEGIN
                DescErrorArray[i] := ErrorText;
                TipoErrorArray[i] := ErrorType;
                added := TRUE;
            END;
        UNTIL (i = ARRAYLEN(DescErrorArray)) OR added;
    end;

    procedure CreateAsyncResponse()
    var
        XmlDomMgnt: Codeunit 6224;
        
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        XmlNode1: DotNet XmlNode;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        XmlNode4: DotNet XmlNode;
        XmlNode5: DotNet XmlNode;
        XmlNode6: DotNet XmlNode;
        XmlNode7: DotNet XmlNode;
        XmlNode8: DotNet XmlNode;
        
        MyDT: DateTime;
        i: Integer;
        Response: Text;
        Content: Text;
        NodeName: Text[20];
    begin
        //+#101415
        IF ConfSant."WS Respuesta MdE" = '' THEN
            EXIT;
        //-#101415

        IF EVALUATE(MyDT, fecha_origen, 9) THEN
            fecha_origen := MdEMgnt.FormatDateTime(DT2DATE(MyDT), DT2TIME(MyDT))
        ELSE IF COPYSTR(fecha_origen, STRLEN(fecha_origen), 1) = 'Z' THEN
            fecha_origen := COPYSTR(fecha_origen, 1, STRLEN(fecha_origen) - 1);

        XmlDoc := XmlDoc.XmlDocument;

        // nivel 0
        IF IsOk THEN BEGIN
            CASE Operacion OF
                'INSERT':
                    NodeName := 'retornoInsert';
                'CHANGE':
                    NodeName := 'retornoUpdate';
                'DELETE':
                    NodeName := 'retornoDelete';
            END;
        END
        ELSE
            // Funciones del WS Hardcoded
            //NodeName := ConfSant."Funcion Error WS MdE";
            NodeName := 'retornoError';

        XmlDoc.LoadXml(
          '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ret="http://retornoAsincrono.santillanaBus">' +
          '<soapenv:Header/>' +
          '<soapenv:Body>' +
          '<ret:' + NodeName + '/>' +
          '</soapenv:Body>' +
          '</soapenv:Envelope>');
        XmlNsMgr := XmlNsMgr.XmlNamespaceManager(XmlDoc.NameTable);
        XmlNsMgr.AddNamespace('soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        XmlNsMgr.AddNamespace('ret', 'http://retornoAsincrono.santillanaBus');
        XmlNode := XmlDoc.SelectSingleNode('//soapenv:Body/ret:' + NodeName, XmlNsMgr);
        XmlDomMgnt.AddElement(XmlNode, 'mensaje', '', NS, XmlNode1);

        // nivel 1
        XmlDomMgnt.AddElement(XmlNode1, 'head', '', NS, XmlNode2);

        // nivel 2
        XmlDomMgnt.AddElement(XmlNode2, 'id_mensaje', id_mensaje, NS, XmlNode3);//de la cabecera recibida
        XmlDomMgnt.AddElement(XmlNode2, 'sistema_origen', ConfSant.GetSistemaOrigen, NS, XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'pais_origen', pais_origen, NS, XmlNode3);
        XmlDomMgnt.AddElement(XmlNode2, 'fecha_origen', fecha_origen, NS, XmlNode3);//de la cabecera recibida
        XmlDomMgnt.AddElement(XmlNode2, 'fecha', MdEMgnt.FormatDateTime(TODAY, TIME), NS, XmlNode3); // este no se informa
        XmlDomMgnt.AddElement(XmlNode2, 'tipo', tipo, NS, XmlNode3); //de la cabecera recibida

        IF NOT IsOk THEN BEGIN
            i := 1;
            WHILE (i <= 10) AND (DescErrorArray[i] <> '') DO BEGIN
                XmlDomMgnt.AddElement(XmlNode2, 'error', '', NS, XmlNode3);

                // nivel 3
                XmlDomMgnt.AddElement(XmlNode3, 'code', 'error', NS, XmlNode4); // ¿?
                XmlDomMgnt.AddElement(XmlNode3, 'level', TipoErrorArray[i], NS, XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'description', DescErrorArray[i], NS, XmlNode4);

                i += 1;
            END;
        END;

        // nivel 1
        XmlDomMgnt.AddElement(XmlNode1, 'body', '', NS, XmlNode2);

        // nivel 2
       
        IF IsOk THEN
            XmlDomMgnt.AddElement(XmlNode2, 'ok', '', NS, XmlNode3)
        ELSE
            XmlNode3 := XmlNode2;

        // nivel 3
        XmlDomMgnt.AddElement(XmlNode3, 'newCodes', '', NS, XmlNode4);

        // nivel 4
        XmlDomMgnt.AddElement(XmlNode4, 'newCodeForElement', '', NS, XmlNode5);
        // nivel 4
        XmlDomMgnt.AddElement(XmlNode5, 'element', 'empleado', NS, XmlNode6);
        XmlDomMgnt.AddElement(XmlNode5, 'pk_fields', '', NS, XmlNode6);

        // ID empleado
        XmlDomMgnt.AddElement(XmlNode6, 'pk_field', '', NS, XmlNode7);
        XmlDomMgnt.AddElement(XmlNode7, 'field_name', 'id', NS, XmlNode8);
        XmlDomMgnt.AddElement(XmlNode7, 'received_value', Numero_persona, NS, XmlNode8);
        XmlDomMgnt.AddElement(XmlNode7, 'new_value', EmployeeNo, NS, XmlNode8);

        // Sociedad
        XmlDomMgnt.AddElement(XmlNode6, 'pk_field', '', NS, XmlNode7);
        XmlDomMgnt.AddElement(XmlNode7, 'field_name', 'sociedad', NS, XmlNode8);
        XmlDomMgnt.AddElement(XmlNode7, 'received_value', Sociedad, NS, XmlNode8);
        XmlDomMgnt.AddElement(XmlNode7, 'new_value', '', NS, XmlNode8);

        IF IsOk THEN
            XmlDomMgnt.AddElement(XmlNode3, 'message', '', NS, XmlNode4)
        ELSE BEGIN
            i := 1;
            WHILE (i <= 10) AND (DescErrorArray[i] <> '') DO BEGIN
                XmlDomMgnt.AddElement(XmlNode2, 'error', '', NS, XmlNode3);

                // nivel 3
                XmlDomMgnt.AddElement(XmlNode3, 'code', 'error', NS, XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'description', TipoErrorArray[i], NS, XmlNode4);
                XmlDomMgnt.AddElement(XmlNode3, 'message', DescErrorArray[i], NS, XmlNode4);

                i += 1;
            END;
        END;

        //+#101415
        //IF USERID <> 'DYNASOFT\PJLLANERAS' THEN // pruebas internas, no enviar al WS la respuesta asincrona
        //MdEMgnt.SendAsyncPostRequest('WS_RESPUESTA_MDE',ConfSant."WS Respuesta MdE", '', XmlDoc.OuterXml);
        MdEMgnt.CreateAsyncPostRequest('WS_RESPUESTA_MDE', ConfSant."WS Respuesta MdE", '', XmlDoc.OuterXml);
        //-#101415

    end;

    procedure SendAsyncResponse()
    begin
        //#101415
        IF ConfSant."WS Respuesta MdE" = '' THEN
            EXIT;

        MdEMgnt.SendAsyncPostRequest();
    end;

    procedure GetInfo(var New_IsOk: Boolean; var New_id_mensaje: Text[36]; var New_Tipo: Text[20]; var New_FechaOrigen: Text[30]; var New_PaisOrigen: Text[20]; var New_DescErrorArray: array[10] of Text; var New_TipoErrorArray: array[10] of Text)
    begin
        New_IsOk := IsOk;
        New_id_mensaje := id_mensaje;
        New_Tipo := tipo;
        New_FechaOrigen := fecha_origen;
        New_PaisOrigen := pais_origen;
        COPYARRAY(New_DescErrorArray, DescErrorArray, 1);
        COPYARRAY(New_TipoErrorArray, TipoErrorArray, 1);
    end;

    local procedure UpdateTextField(var TextVar: Text[200]; NewValue: Text; TableRel: Integer; NodeName: Text[80]; FieldCaption: Text[80]; FieldLenght: Integer)
    begin
        IF STRLEN(NewValue) > FieldLenght THEN
            AddError(STRSUBSTNO(ErrorTamanoCampo, NodeName, NewValue, FieldCaption, FieldLenght), ErrorTipoDatos)
        ELSE
            TextVar := NewValue;

        IF IsOk AND (TableRel > 0) THEN
            ValidateTableRel(NewValue, TableRel, NodeName, '');
    end;

    local procedure UpdateCodeField(var CodeVar: Code[100]; NewValue: Text; TableRel: Integer; NodeName: Text[80]; FieldCaption: Text[80]; FieldLenght: Integer; DimensionCode: Code[20])
    var
        DefaultDim: Record 352;
    begin
        IF STRLEN(NewValue) > FieldLenght THEN
            AddError(STRSUBSTNO(ErrorTamanoCampo, NodeName, NewValue, FieldCaption, FieldLenght), ErrorTipoDatos)
        ELSE IF DimensionCode = '' THEN
            CodeVar := NewValue;

        IF IsOk AND (TableRel > 0) THEN BEGIN
            ValidateTableRel(NewValue, TableRel, NodeName, DimensionCode);
            IF CreateDefaultDim THEN //+#81969
                IF IsOk AND NOT ('' IN [DimensionCode, NewValue, EmployeeNo]) AND (TableRel = DATABASE::"Dimension Value") THEN BEGIN
                    DefaultDim.SetFromMde(TRUE);
                    IF DefaultDim.GET(DATABASE::Employee, EmployeeNo, DimensionCode) THEN BEGIN
                        DefaultDim."Dimension Value Code" := NewValue;
                        IF NOT DefaultDim.MODIFY(TRUE) THEN BEGIN // (TRUE) --> Si son dimensiones globales, tienen que actualizar la ficha
                            AddError(STRSUBSTNO(ErrorModify, DefaultDim.TABLECAPTION, Numero_persona), ErrorTipoDatos);
                            EXIT;
                        END;
                    END
                    ELSE BEGIN
                        DefaultDim."Table ID" := DATABASE::Employee;
                        DefaultDim."No." := EmployeeNo;
                        DefaultDim."Dimension Code" := DimensionCode;
                        DefaultDim."Dimension Value Code" := NewValue;
                        IF NOT DefaultDim.INSERT(TRUE) THEN BEGIN // (TRUE) --> Si son dimensiones globales, tienen que actualizar la ficha
                            AddError(STRSUBSTNO(ErrorInsert, DefaultDim.TABLECAPTION, Numero_persona), ErrorTipoDatos);
                            EXIT;
                        END;
                    END;
                END;
        END;
    end;

    local procedure UpdateOptField(var OptVar: Option; NewValue: Text; TableRel: Integer; NodeName: Text[80]; FieldCaption: Text[80])
    begin
        IF NOT EVALUATE(OptVar, NewValue) THEN
            AddError(STRSUBSTNO(ErrorTipoVar, NodeName, NewValue, FieldCaption), ErrorTipoDatos);

        IF IsOk AND (TableRel > 0) THEN
            ValidateTableRel(NewValue, TableRel, NodeName, '');
    end;

    local procedure UpdateDateField(var DateVar: Date; NewValue: Text; TableRel: Integer; NodeName: Text[80]; FieldCaption: Text[80])
    var
        DateTimeVar: DateTime;
    begin
        IF NOT EVALUATE(DateTimeVar, NewValue, 9) THEN
            AddError(STRSUBSTNO(ErrorTipoVar, NodeName, NewValue, FieldCaption), ErrorTipoDatos)
        ELSE
            DateVar := DT2DATE(DateTimeVar);

        IF IsOk AND (TableRel > 0) THEN
            ValidateTableRel(FORMAT(DateVar), TableRel, NodeName, '');
    end;

    local procedure ValidateTableRel(NewValue: Text[200]; TableRel: Integer; NodeName: Text[80]; DimensionCode: Code[20])
    var
        rPais: Record 9;
        rCodPostal: Record 225;
        rContrato: Record 5211;
        rCentro: Record 34002101;
        rPuesto: Record 34002110;
        rMotivoBaja: Record 5217;
        rDptos: Record 34002135;
        rDim: Record 348;
        rDimVal: Record 349;
    begin
        CASE TableRel OF
            DATABASE::"Country/Region":
                BEGIN
                    rPais.SETRANGE(Code, NewValue);
                    IF NOT rPais.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, NewValue, rPais.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Post Code":
                BEGIN
                    // No validamos el CP
                    //rCodPostal.SETRANGE(Code, NewValue);
                    //IF NOT rCodPostal.FINDFIRST THEN
                    //  AddError(STRSUBSTNO(ErrorTablaRel,NodeName,NewValue,rCodPostal.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Centros de Trabajo":
                BEGIN
                    rCentro.SETRANGE("Centro de trabajo", NewValue);
                    rCentro.SETRANGE("Empresa cotizacion", EmpCotiz."Empresa cotizacion");
                    IF NOT rCentro.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, EmpCotiz."Empresa cotizacion" + '-' + NewValue, rCentro.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Employment Contract":
                BEGIN
                    rContrato.SETRANGE(Code, NewValue);
                    IF NOT rContrato.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, NewValue, rContrato.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Puestos laborales":
                BEGIN
                    rPuesto.SETRANGE(Codigo, NewValue);
                    IF NOT rPuesto.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, NewValue, rPuesto.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::Departamentos:
                BEGIN
                    rDptos.SETRANGE(Codigo, NewValue);
                    IF NOT rDptos.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, NewValue, rDptos.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Grounds for Termination":
                BEGIN
                    rMotivoBaja.SETRANGE(Code, NewValue);
                    IF NOT rMotivoBaja.FINDFIRST THEN
                        AddError(STRSUBSTNO(ErrorTablaRel, NodeName, NewValue, rMotivoBaja.TABLECAPTION), ErrorTipoDatos);
                END;
            DATABASE::"Dimension Value":
                BEGIN
                    IF NOT rDim.GET(DimensionCode) THEN
                        AddError(STRSUBSTNO(ErrorDimension, NodeName, DimensionCode), ErrorTipoDatos);
                    IF NOT rDimVal.GET(DimensionCode, NewValue) THEN
                        AddError(STRSUBSTNO(ErrorValorDimension, NodeName, NewValue, DimensionCode), ErrorTipoDatos);
                END;
        END;
    end;

    local procedure LocalizarEmpleadoError(Create: Boolean) Error: Boolean
    var
        Found: Boolean;
        DocID: Text[15];
        NewDocID: Text[15];
        DocType: Integer;
    begin
        IF Create THEN
            CLEAR(EmployeeNo)
        ELSE
            EmployeeNo := Numero_persona_sistema_loca;

        Found := Employee.GET(EmployeeNo);
        IF NOT Found THEN BEGIN
            Employee.SETRANGE("Numero de persona", Numero_persona);
            Found := Employee.FINDFIRST;
            IF Found THEN
                Found := Employee."Document ID" = Numero_documento;
            IF NOT Found THEN BEGIN
                CLEAR(Employee);
                UpdateOptField(Employee."Document Type", Tipo_documento, 0, 'Tipo_documento', Employee.FIELDCAPTION("Document Type"));
                UpdateTextField(Employee."Document ID", Numero_documento, 0, 'Numero_documento', Employee.FIELDCAPTION("Document ID"), MAXSTRLEN(Employee."Document ID"));
                IF NOT IsOk THEN
                    EXIT(TRUE);
                DocType := Employee."Document Type";
                DocID := Employee."Document ID";
                Employee.SETRANGE("Document Type", DocType);
                Employee.SETRANGE("Document ID", DocID);
                Found := Employee.FINDFIRST;

                IF NOT Found THEN BEGIN
                    NewDocID := DELCHR(DocID, '=', '\|@#~€¬º''¡ª!"·$%&/()=?¿[]{}`+´ç,.-<^*¨Ç;:_>');
                    IF NewDocID <> DocID THEN BEGIN
                        Employee.SETRANGE("Document ID", NewDocID);
                        Found := Employee.FINDFIRST;
                    END;
                END;

            END;
        END;

        IF Create THEN BEGIN
            IF Found THEN BEGIN
                AddError(STRSUBSTNO(ErrorEmployeeExist, Employee."No.", Employee."Document Type", Employee."Document ID", Numero_persona), ErrorTipoDatos);
                EXIT(TRUE);
            END;
            Employee.INIT;
        END
        ELSE BEGIN
            IF NOT Found THEN BEGIN
                AddError(STRSUBSTNO(ErrorEmployeeDoNotExist, 'Numero_persona', Numero_persona), ErrorTipoDatos);
                EXIT(TRUE);
            END;
            EmployeeNo := Employee."No.";
        END;

        EXIT(FALSE);
    end;

    procedure IsNewContract(): Boolean
    begin
        EXIT(Motivo_contratacion_sistema IN ['AltasNAV01', 'AltasNAV02', 'AltasNAV03', 'AltasNAV04', 'AltasNAV05', 'AltasNAV06', 'AltasNAV07', 'AltasNAV13', 'AltasNAV14']);
    end;

    procedure IsRecontratacion(): Boolean
    begin
        EXIT(Motivo_contratacion_sistema IN ['AltasNAV08', 'AltasNAV09', 'AltasNAV10', 'AltasNAV11']);
    end;

    procedure GetOutStrm(var wOutStrm: OutStream)
    begin
        //+#101415
        MdEMgnt.GetOutStrm(wOutStrm);

        Exporting := TRUE;
    end;

    procedure UpdateMdEHistory()
    begin
        //+#81969
        WITH MdEHistory DO BEGIN
            INIT;
            "No." := '';
            "No. Mov." := 0;
            "Fecha y hora recepcion" := CURRENTDATETIME;

            CASE Operacion OF
                'INSERT':
                    BEGIN
                        "Tipo envio" := "Tipo envio"::INSERT;

                        // campos employee
                        "M nombre" := Nombre <> '';
                        "M primer apellido" := Primer_apellido <> '';
                        "M segundo apellido" := Segundo_apellido <> '';
                        "M fecha antiguedad reconoci" := Fecha_antiguedad_reconocida <> '';
                        "M tipo documento" := Tipo_documento <> '';
                        "M numero documento" := Numero_documento <> '';
                        "M genero" := Genero <> '';
                        "M estado civil" := Estado_civil <> '';
                        "M fecha nacimiento" := Fecha_nacimiento <> '';
                        "M provincia nacimiento" := Provincia_nacimiento <> '';
                        "M pais nacimiento" := Pais_nacimiento <> '';
                        "M nacionalidad" := Nacionalidad <> '';
                        "M pais" := Pais <> '';
                        "M nombre calle" := Nombre_calle <> '';
                        "M ciudad" := Ciudad <> '';
                        "M codigo postal" := Codigo_postal <> '';
                        "M provincia" := Provincia <> '';
                        "M direccion" := Direccion <> '';
                        "M numero telefono" := Numero_telefono <> '';
                        "M posicion" := Posicion <> '';
                        "M centro trabajo" := Centro_trabajo <> '';
                        "M Categoria grupo" := Categoria_grupo <> '';
                        "M tipo contrato grupo" := Tipo_contrato_grupo <> '';

                        // Campos configurables (division/dimension)
                        "M departamento" := Departamento <> '';
                        "M division" := Division <> '';
                        "M area funcional grupo" := Area_funcional_grupo <> '';

                        // campos contrato
                        "M fecha inicio contrato" := Fecha_inicio_contrato <> '';
                        "M fecha fin contrato" := Fecha_fin_contrato <> '';
                        "M tipo baja" := Tipo_baja <> '';
                    END;
                'CHANGE':
                    BEGIN
                        "Tipo envio" := "Tipo envio"::CHANGE;

                        // campos employee
                        "M nombre" := Modified(M_nombre);
                        "M primer apellido" := Modified(M_primer_apellido);
                        "M segundo apellido" := Modified(M_segundo_apellido);
                        "M fecha antiguedad reconoci" := Modified(M_fecha_antiguedad_reconoci);
                        "M tipo documento" := Modified(M_tipo_documento);
                        "M numero documento" := Modified(M_numero_documento);
                        "M genero" := Modified(M_genero);
                        "M estado civil" := Modified(M_estado_civil);
                        "M fecha nacimiento" := Modified(M_fecha_nacimiento);
                        "M provincia nacimiento" := Modified(M_provincia_nacimiento);
                        "M pais nacimiento" := Modified(M_pais_nacimiento);
                        "M nacionalidad" := Modified(M_nacionalidad);
                        "M pais" := Modified(M_pais);
                        "M nombre calle" := Modified(M_nombre_calle);
                        "M ciudad" := Modified(M_ciudad);
                        "M codigo postal" := Modified(M_codigo_postal);
                        "M provincia" := Modified(M_provincia);
                        "M direccion" := Modified(M_direccion);
                        "M numero telefono" := Modified(M_numero_telefono);
                        "M posicion" := Modified(M_posicion);
                        "M centro trabajo" := Modified(M_centro_trabajo);
                        "M Categoria grupo" := Modified(M_Categoria_grupo);
                        "M tipo contrato grupo" := Modified(M_tipo_contrato_grupo);

                        // Campos configurables (division/dimension)
                        "M departamento" := Modified(M_departamento);
                        "M division" := Modified(M_division);
                        "M area funcional grupo" := Modified(M_area_funcional_grupo);

                        // campos contrato
                        "M fecha inicio contrato" := Modified(M_fecha_inicio_contrato);
                        "M fecha fin contrato" := Modified(M_fecha_fin_contrato);
                        "M tipo baja" := Modified(M_tipo_baja);
                    END;
                'DELETE':
                    BEGIN
                        "Tipo envio" := "Tipo envio"::DELETE;

                        IF Fecha_fin_contrato = '' THEN BEGIN
                            AddError(STRSUBSTNO(ErrorDatoObligatorio, 'DELETE', 'Fecha_fin_contrato'), ErrorTipoDatos);
                            EXIT;
                        END;
                        IF Tipo_baja = '' THEN BEGIN
                            AddError(STRSUBSTNO(ErrorDatoObligatorio, 'DELETE', 'Tipo_baja'), ErrorTipoDatos);
                            EXIT;
                        END;

                        "M fecha fin contrato" := TRUE;
                        "M tipo baja" := TRUE;
                    END;
            END;

            UpdateDateField("Fecha efectiva", Fecha_efectiva, 0, 'Fecha_efectiva', FIELDCAPTION("Fecha efectiva"));
            IF "Fecha efectiva" = 0D THEN
                "Fecha efectiva" := TODAY;

            IF "Numero de persona" <> Numero_persona THEN
                UpdateTextField("Numero de persona", Numero_persona, 0, 'Numero_persona', FIELDCAPTION("Numero de persona"), MAXSTRLEN("Numero de persona"));
            Company := EmpCotiz."Empresa cotizacion";
            IF "M nombre" THEN
                "First Name" := COPYSTR(Nombre, 1, MAXSTRLEN("First Name"));
            IF "M primer apellido" THEN
                "Last Name" := COPYSTR(Primer_apellido, 1, MAXSTRLEN("Last Name"));
            IF "M segundo apellido" THEN
                "Second Last Name" := COPYSTR(Segundo_apellido, 1, MAXSTRLEN("Second Last Name"));
            VALIDATE("Full Name");

            IF "M fecha antiguedad reconoci" THEN
                UpdateDateField("Employment Date", Fecha_antiguedad_reconocida, 0, 'Fecha_antiguedad_reconocida', FIELDCAPTION("Employment Date"));

            IF "M tipo documento" THEN
                UpdateOptField("Document Type", Tipo_documento, 0, 'Tipo_documento', FIELDCAPTION("Document Type"));
            IF "M numero documento" THEN
                UpdateTextField("Document ID", Numero_documento, 0, 'Numero_documento', FIELDCAPTION("Document ID"), MAXSTRLEN("Document ID"));

            IF "M genero" THEN
                UpdateOptField(Gender, Genero, 0, 'Genero', FIELDCAPTION(Gender));
            IF "M estado civil" THEN
                UpdateOptField("Estado civil", Estado_civil, 0, 'Estado_civil', FIELDCAPTION("Estado civil"));
            IF "M fecha nacimiento" THEN
                UpdateDateField("Birth Date", Fecha_nacimiento, 0, 'Fecha_nacimiento', FIELDCAPTION("Birth Date"));
            IF "M provincia nacimiento" OR "M pais nacimiento" THEN
                UpdateTextField("Lugar nacimiento", COPYSTR(Provincia_nacimiento + '-' + Pais_nacimiento, 1, MAXSTRLEN("Lugar nacimiento")),
                  0, 'Provincia_nacimiento y Pais_nacimiento', FIELDCAPTION("Lugar nacimiento"), MAXSTRLEN("Lugar nacimiento"));

            IF "M nacionalidad" THEN
                UpdateCodeField(_Nacionalidad, Nacionalidad, DATABASE::"Country/Region", 'Nacionalidad', FIELDCAPTION(_Nacionalidad), MAXSTRLEN(_Nacionalidad), '');
            IF "M pais" THEN
                UpdateCodeField("Country/Region Code", Pais, DATABASE::"Country/Region", 'Pais', FIELDCAPTION("Country/Region Code"), MAXSTRLEN("Country/Region Code"), '');
            IF "M nombre calle" THEN
                UpdateTextField(Address, Nombre_calle, 0, 'Nombre_calle', FIELDCAPTION(Address), MAXSTRLEN(Address));
            IF "M ciudad" THEN
                UpdateTextField(City, Ciudad, 0, 'Ciudad', FIELDCAPTION(City), MAXSTRLEN(City));
            IF "M codigo postal" THEN
                UpdateCodeField("Post Code", Codigo_postal, DATABASE::"Post Code", 'Codigo_postal', FIELDCAPTION("Post Code"), MAXSTRLEN("Post Code"), '');
            IF "M provincia" THEN
                UpdateTextField(County, Provincia, 0, 'Provincia', FIELDCAPTION(County), MAXSTRLEN(County));

            IF "M direccion" THEN
                UpdateTextField("E-Mail", Direccion, 0, 'Direccion', FIELDCAPTION("E-Mail"), MAXSTRLEN("E-Mail"));
            IF "M numero telefono" THEN
                UpdateTextField("Phone No.", Numero_telefono, 0, 'Numero_telefono', FIELDCAPTION("Phone No."), MAXSTRLEN("Phone No."));

            IF "M posicion" THEN
                IF ConfSant."Posicion MdE" = ConfSant."Posicion MdE"::"Puesto laboral" THEN
                    UpdateCodeField("Job Type Code", Posicion, DATABASE::"Puestos laborales", 'Posicion', FIELDCAPTION("Job Type Code"), MAXSTRLEN("Job Type Code"), '');

            IF "M centro trabajo" THEN
                UpdateCodeField("Working Center", Centro_trabajo, DATABASE::"Centros de Trabajo", 'Centro_trabajo', FIELDCAPTION("Working Center"), MAXSTRLEN("Working Center"), '');
            IF "M Categoria grupo" THEN
                UpdateOptField(_Categoria, Categoria_grupo, 0, 'Categoria_grupo', FIELDCAPTION(_Categoria));
            IF "M tipo contrato grupo" THEN
                UpdateCodeField("Emplymt. Contract Code", Tipo_contrato_grupo, DATABASE::"Employment Contract", 'Tipo_contrato_grupo', FIELDCAPTION("Emplymt. Contract Code"), MAXSTRLEN("Emplymt. Contract Code"), '');

            // Campos configurables (division)
            IF "M departamento" AND (ConfSant."Departamento MdE" = ConfSant."Departamento MdE"::Division) THEN
                UpdateCodeField(_Departamento, Departamento, DATABASE::Departamentos, 'Departamento', FIELDCAPTION(_Departamento), MAXSTRLEN(_Departamento), '');
            IF "M division" AND (ConfSant."Division MdE" = ConfSant."Division MdE"::Division) THEN
                UpdateCodeField(_Departamento, Division, DATABASE::Departamentos, 'Division', FIELDCAPTION(_Departamento), MAXSTRLEN(_Departamento), '');
            IF "M area funcional grupo" AND (ConfSant."Area funcional MdE" = ConfSant."Area funcional MdE"::Division) THEN
                UpdateCodeField(_Departamento, Area_funcional_grupo, DATABASE::Departamentos, 'Area_funcional_grupo', FIELDCAPTION(_Departamento), MAXSTRLEN(_Departamento), '');

            IF NOT IsOk THEN
                EXIT;

            // Campos configurables (dimension)
            IF "M departamento" AND (ConfSant."Departamento MdE" = ConfSant."Departamento MdE"::Dimension) THEN BEGIN
                "Cod. Dimension" := ConfSant."Dimension Departamento";
                UpdateCodeField("Valor Dimension", Departamento, DATABASE::"Dimension Value", 'Departamento', STRSUBSTNO(DimensionTxt, ConfSant."Dimension Departamento"), MAXSTRLEN(CodeValue), ConfSant."Dimension Departamento");
            END;
            IF "M division" AND (ConfSant."Division MdE" = ConfSant."Division MdE"::Dimension) THEN BEGIN
                "Cod. Dimension" := ConfSant."Dimension Division";
                UpdateCodeField("Valor Dimension", Division, DATABASE::"Dimension Value", 'Division', STRSUBSTNO(DimensionTxt, ConfSant."Dimension Division"), MAXSTRLEN(CodeValue), ConfSant."Dimension Division");
            END;
            IF "M area funcional grupo" AND (ConfSant."Area funcional MdE" = ConfSant."Area funcional MdE"::Dimension) THEN BEGIN
                "Cod. Dimension" := ConfSant."Dimension Area funcional";
                UpdateCodeField("Valor Dimension", Area_funcional_grupo, DATABASE::"Dimension Value", 'Area_funcional_grupo', STRSUBSTNO(DimensionTxt, ConfSant."Dimension Area funcional"), MAXSTRLEN(CodeValue), ConfSant."Dimension Area funcional");
            END;

            // Campos tabla 34002109 "Contratos"
            IF "M fecha inicio contrato" THEN
                UpdateDateField("Alta contrato", Fecha_inicio_contrato, 0, 'Fecha_inicio_contrato', FIELDCAPTION("Alta contrato"));
            IF "M fecha fin contrato" THEN
                UpdateDateField("Fin contrato", Fecha_fin_contrato, 0, 'Fecha_fin_contrato', FIELDCAPTION("Fin contrato"));
            IF "M tipo baja" THEN
                UpdateCodeField("Grounds for Term. Code", Tipo_baja, DATABASE::"Grounds for Termination", 'Tipo_baja', FIELDCAPTION("Grounds for Term. Code"), MAXSTRLEN("Grounds for Term. Code"), '');
            IF ("Fin contrato" <> 0D) AND ("Alta contrato" > "Fin contrato") THEN BEGIN
                AddError(STRSUBSTNO(ErrorFechas, "Alta contrato", "Fin contrato"), ErrorTipoDatos);
                EXIT;
            END;

            IF "M tipo contrato grupo" THEN
                VALIDATE("Emplymt. Contract Code");

            IF IsOk THEN BEGIN
                IF "M fecha inicio contrato" THEN
                    VALIDATE("Alta contrato");
                IF "M fecha fin contrato" THEN
                    VALIDATE("Fin contrato");
            END;
        END;
    end;
    */
}

