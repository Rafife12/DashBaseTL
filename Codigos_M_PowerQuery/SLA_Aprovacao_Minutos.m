= Table.AddColumn(#"EtapaAnterior", "sla_aprov", each Duration.TotalMinutes(
    Duration.From([Data_Aprovacao_1] - [Dt_1_Envio_Orcamento])
))
