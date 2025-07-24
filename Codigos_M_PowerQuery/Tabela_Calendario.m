let
    DataInicial = #date(2024, 1, 1),
    DataFinal = List.Max(BASE_TL_ACUMULADA[Data_Aprovacao_1.1]),
    ListaDatas = List.Dates(DataInicial, Duration.Days(DataFinal - DataInicial) + 1, #duration(1, 0, 0, 0)),
    TabelaCalendario = Table.FromList(ListaDatas, Splitter.SplitByNothing(), {"Date"}),
    TabelaComColunas = Table.AddColumn(TabelaCalendario, "MESANO", each Text.PadStart(Text.From(Date.Month([Date])), 2, "0") & "/" & Text.End(Text.From(Date.Year([Date])), 2))
in
    TabelaComColunas
