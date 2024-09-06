MERGE `warehouse.local_tabela.tabela_original` AS destino
USING (
  SELECT * FROM `warehouse.local_tabela_temp.tabela`) AS origem
ON destino.tabela_id   =   origem.tabela_id
WHEN MATCHED THEN
  UPDATE SET
destino.tabela_id = origem.tabela_id,
destino.campo_1 = origem.campo1

WHEN NOT MATCHED THEN
  INSERT (
tabela_id,
campo_1
)
VALUES (
origem.tabela_id,
origem.campo_1
)
