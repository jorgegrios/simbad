create or replace Package Body       STX_TDRV_FORMULA_CODB
IS
--
-- Create by    :   Juan Carlos Lozada B.
-- Date of      :   21 de Julio del 2000
-- Purpose      :   Inserta los datos en la tabla formula_codb
--                  y devuelve TRUE si la insercion es exitosa o FALSE si no lo es.
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  ------------------------------------------

  FUNCTION  crear_registro(p_registro in formula_codb%ROWTYPE,
                           p_commit IN BOOLEAN )
    RETURN  BOOLEAN IS
      p_compania parametros_compania.parc_parc_compania%type;
      p_usuario parametros_compania.usuario_crea%type;
  BEGIN
    p_compania := p_registro.ref_art_tdp_parc_parc_compania;
    p_usuario := p_registro.usuario_crea;
    --comentario Mayo 1 de 2021
	INSERT INTO formula_codb( costo,cantidad,unidad,factor_consumo,factor_tolerancia,costo_aplicado,
                              codigo_barra,tdp_tipo_de_producto,referencia,talla,color,numero_serie,
                              descripcion,usuario_crea,usuario_modifica,fecha_creacion,fecha_modificacion,
                              det_ref_codigo_barra,ref_art_tdp_parc_parc_compania,deref_art_tdp_tipo_de_producto,
                              det_ref_ref_art_referencia,det_ref_color,det_ref_talla,requiere_corte)
	VALUES(	p_registro.costo,p_registro.cantidad,p_registro.unidad,p_registro.factor_consumo,
            p_registro.factor_tolerancia,p_registro.costo_aplicado,p_registro.codigo_barra,
            p_registro.tdp_tipo_de_producto,p_registro.referencia,p_registro.talla,p_registro.color,
            p_registro.numero_serie,p_registro.descripcion,p_registro.usuario_crea,p_registro.usuario_modifica,
            p_registro.fecha_creacion,p_registro.fecha_modificacion,p_registro.det_ref_codigo_barra,
            p_registro.ref_art_tdp_parc_parc_compania,p_registro.deref_art_tdp_tipo_de_producto,
            p_registro.det_ref_ref_art_referencia,p_registro.det_ref_color,p_registro.det_ref_talla,
            p_registro.requiere_corte);
    if p_commit then
      commit;
    end if;
    RETURN TRUE;
  exception
    when program_error then
      fct_log.log (p_compania, p_usuario, 'IFORM',
                    0 ,
                    'Insertando en formula codb',
                    'Agregando informacion en formula codb. Error en Programa',
                    -20000,
                    'E');
      fct_log.transferir;
      return false;
    when  storage_error then
      fct_log.log (p_compania, p_usuario, 'IFORM',
                    0 ,
                    'Insertando en formula codb',
                    'Agregando informacion en formula codb. Error en Almacenamiento',
                    -20001,
                    'E');
      fct_log.transferir;
      return false;
    when  timeout_on_resource then
      fct_log.log (p_compania, p_usuario, 'IFORM',
                    0 ,
                    'Insertando en formula codb',
                    'Agregando informacion en formula codb. Tiempo Limite alcanzado',
                    -20002,
                    'E');
      fct_log.transferir;
      return false;
    when  value_error then
      fct_log.log (p_compania, p_usuario, 'IFORM',
                    0 ,
                    'Insertando en formula codb',
                    'Agregando informacion en formula codb. Error en Valor',
                    -20003,
                    'E');
      fct_log.transferir;
      return false;
    when  dup_val_on_Index then
      fct_log.log (p_compania, p_usuario, 'IFORM',
                    0 ,
                    'Insertando en formula codb',
                    'Agregando informacion en formula codb. Error valor Duplicado',
                    -20001,
                    'E');
      fct_log.transferir;
      return false;
  END; --FUNCTION  crear_registro
END; -- Package Body STX_TDRV_FORMULA_CODB