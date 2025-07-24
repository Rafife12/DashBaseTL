# 📊 DashBaseTL - Dashboard de Aprovações Técnicas de OS

Este projeto em Power BI tem como objetivo **monitorar e analisar o desempenho das aprovações técnicas de ordens de serviço (OS)**, considerando métricas como SLA, produtividade, volume mensal e eficiência por gestor responsável.

## 📌 Visão Geral

O relatório exibe indicadores estratégicos, detalhamento operacional e gráficos de tendência, permitindo um acompanhamento gerencial preciso.

### 🔎 Métricas Chave:
- **Total de OS** aprovadas
- **Valor total aprovado**
- **Valor médio por OS**
- **Dias úteis trabalhados**
- **Média de aprovações por dia útil**
- **Tempo médio de aprovação (SLA)**

---

## 🖼️ Capturas de Tela

### ✅ Página Inicial (Dashboard):
![Dashboard - Visão Geral](./Captura%20de%20tela%202025-07-24%20101517.png)

### ✅ Modelo de Dados:
![Modelo Relacional](./Captura%20de%20tela%202025-07-24%20101634.png)

---

## 🧠 Modelagem e Lógica

### 🗂️ Estrutura do Modelo de Dados

O modelo segue a arquitetura em estrela, com as seguintes tabelas principais:

| Tabela               | Tipo         | Descrição                                                                 |
|----------------------|--------------|---------------------------------------------------------------------------|
| BASE_TL_ACUMULADA    | Fato         | Registro das OSs e datas de aprovação                                     |
| D_Validador          | Dimensão     | Informações dos responsáveis pelas aprovações (gestor, área, função etc.)|
| CALENDARIO           | Dimensão     | Tabela de datas para análise temporal                                     |
| DIAS_UTEIS           | Auxiliar     | Quantidade de dias úteis por mês                                          |
| Medidas              | Auxiliar     | Tabela com medidas DAX calculadas                                         |

---

## 🧾 Códigos M (Power Query)

### ⏱️ SLA de Aprovação (em minutos)

```m
= Table.AddColumn(#"EtapaAnterior", "sla_aprov", each Duration.TotalMinutes(
    Duration.From([Data_Aprovacao_1] - [Dt_1_Envio_Orcamento])
))
```

### 📆 Tabela de Calendário

```m
let
    DataInicial = #date(2024, 1, 1),
    DataFinal = List.Max(BASE_TL_ACUMULADA[Data_Aprovacao_1.1]),
    ListaDatas = List.Dates(DataInicial, Duration.Days(DataFinal - DataInicial)+1, #duration(1,0,0,0)),
    TabelaCalendario = Table.FromList(ListaDatas, Splitter.SplitByNothing(), {"Date"}),
    TabelaComColunas = Table.AddColumn(TabelaCalendario, "MESANO", each Text.PadStart(Text.From(Date.Month([Date])), 2, "0") & "/" & Text.End(Text.From(Date.Year([Date])), 2))
in
    TabelaComColunas
```

---

## 📈 Visualizações

- Indicadores (Cards) com totais e médias
- Tabela dinâmica por **Gestor do Produto**
- Gráfico de colunas com **QTD_OS por mês**
- Filtros dinâmicos para análise por área, cliente, mês e tipo

---

## 📁 Requisitos

- Power BI Desktop
- Dataset base: `BASE_TL_ACUMULADA`, `D_Validador`, `DIAS_UTEIS`

---

## 👤 Autor

**Rafael Souza Da Silva**  
Estudante de Engenharia de Computação | Power BI & Dados  
📧 rafael.souzadsilva1@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/rafael-souza-da-silva/)  

---

## 📌 Observações

Este dashboard pode ser expandido com novas métricas, análises de tendência e integração com fontes automatizadas de dados via gateway. Para contribuições ou dúvidas, fique à vontade para abrir um *issue* ou fazer um *fork*.
