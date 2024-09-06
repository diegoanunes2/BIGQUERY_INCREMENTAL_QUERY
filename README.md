# BIGQUERY_INCREMENTAL_QUERY

## Introdução
Essa query realiza uma operação de MERGE no BigQuery, que combina ações de UPDATE e INSERT em uma única instrução. abaixo temos o  passo a passo o que a query faz:

## Estrutura Geral:
A query está mesclando dados da tabela warehouse-pibernat.fcomex_exportacao_incr.lpcos_procs (chamada de origem) na tabela warehouse-pibernat.fcomex_exportacao.lpcos_procs (chamada de destino). Dependendo se há uma correspondência nos registros (baseada no campo processo_id), ela atualiza ou insere novos dados.

Passo a Passo:
## 1 - Declaração MERGE:
````sql
MERGE `warehouse.local_tabela_original.tabela` AS destino
USING (
  SELECT * FROM `warehouse.local_tabela_temporaria.tabela`
) AS origem
````
- A operação começa com a declaração de um MERGE na tabela de destino warehouse-pibernat.fcomex_exportacao.lpcos_procs.<br>
- A tabela de origem é definida por um SELECT de todos os dados da tabela warehouse-pibernat.fcomex_exportacao_incr.lpcos_procs.

## 2 - Condição de Correspondência (ON):
````sql
ON destino.tabela_id = origem.tabela_id
````
-Esta linha define a condição de correspondência entre a tabela de destino e a tabela de origem. Ela indica que a correspondência entre os registros será feita com base no campo processo_id.

## 3 - Ação quando há correspondência (WHEN MATCHED):
````sql
WHEN MATCHED THEN
  UPDATE SET
  destino.tabela_id = origem.tabela_id,
  destino.campo_1 = origem.campo_1
````

- Quando há uma correspondência, ou seja, quando o processo_id da tabela de origem é igual ao processo_id da tabela de destino, A instrução UPDATE atualiza os campos processo_id e lpco_id na tabela de destino com os valores correspondentes da tabela de origem.

## 4 - Ação quando não há correspondência (WHEN NOT MATCHED):
````sql
WHEN NOT MATCHED THEN
  INSERT (
  tabela_id,
  campo_1
  )
  VALUES (
  origem.tabela_id,
  origem.campo_1
  )
````
-Quando não há correspondência, ou seja, quando o processo_id da tabela de origem não existe na tabela de destino, A instrução INSERT insere um novo registro na tabela de destino com os valores de processo_id e lpco_id da tabela de origem.


## Resumo:
- MERGE combina dados entre duas tabelas, atualizando registros existentes e inserindo novos registros, dependendo da correspondência entre os valores de processo_id.<br>
- USING define a tabela de origem com os dados a serem mesclados.<br>
- ON especifica a condição de correspondência entre as tabelas.<br>
- WHEN MATCHED THEN UPDATE atualiza os registros da tabela de destino que correspondem aos registros da tabela de origem.<br>
- WHEN NOT MATCHED THEN INSERT insere novos registros na tabela de destino quando não há correspondência com os registros da tabela de origem.<br>
Essa query é usada para manter a tabela de destino atualizada com os dados da tabela de origem, evitando duplicação de dados e garantindo que os registros correspondentes sejam atualizados.<br>
