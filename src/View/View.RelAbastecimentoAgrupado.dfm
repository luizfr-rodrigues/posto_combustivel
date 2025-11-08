object FrmRelAbastecimentoAgrupado: TFrmRelAbastecimentoAgrupado
  Left = 0
  Top = 0
  Caption = 'FrmRelAbastecimentoAgrupado'
  ClientHeight = 784
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object RLReport: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DataSource
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLGroupData: TRLGroup
      Left = 38
      Top = 103
      Width = 718
      Height = 114
      DataFields = 'data_abastecimento'
      object RLBandCabecalhoGroup: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 35
        BandType = btTitle
        object RLLabDataAbastecimento: TRLLabel
          Left = 8
          Top = 10
          Width = 41
          Height = 16
          Caption = 'Data: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBTextDataAbastecimento: TRLDBText
          Left = 53
          Top = 10
          Width = 132
          Height = 16
          DataField = 'data_abastecimento'
          DataSource = DataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Text = ''
        end
      end
      object RLBandDetalhe: TRLBand
        Left = 0
        Top = 35
        Width = 718
        Height = 20
        object RLDBTextValor: TRLDBText
          Left = 424
          Top = 2
          Width = 150
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'total_valor'
          DataSource = DataSource
          Holder = RLLabValor
          Text = ''
        end
        object RLDBTextNumeroBomba: TRLDBText
          Left = 20
          Top = 2
          Width = 93
          Height = 16
          AutoSize = False
          DataField = 'numero_bomba'
          DataSource = DataSource
          Holder = RLLabNumeroBomba
          Text = ''
        end
        object RLDBTextNumeroTanque: TRLDBText
          Left = 119
          Top = 2
          Width = 93
          Height = 16
          AutoSize = False
          DataField = 'numero_tanque'
          DataSource = DataSource
          Holder = RLLabNumeroTanque
          Text = ''
        end
        object RLDBTextDescrTipoCombustivel: TRLDBText
          Left = 218
          Top = 2
          Width = 200
          Height = 16
          AutoSize = False
          DataField = 'descricao_tipo_combustivel'
          DataSource = DataSource
          Holder = RLLabDescrTipoCombustivel
          Text = ''
        end
      end
      object RLBandRodabeGroup: TRLBand
        Left = 0
        Top = 55
        Width = 718
        Height = 29
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        object RLDBResultValor: TRLDBResult
          Left = 424
          Top = 10
          Width = 150
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'total_valor'
          DataSource = DataSource
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Holder = RLLabValor
          Info = riSum
          ParentFont = False
          Text = ''
        end
        object RLLabTotalGroup: TRLLabel
          Left = 378
          Top = 10
          Width = 40
          Height = 16
          Caption = 'Total:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBandCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 65
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Borders.FixedBottom = True
      object RLLabTituloRelatorio: TRLLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 718
        Height = 22
        Align = faTop
        Alignment = taCenter
        Caption = 'Relat'#243'rio de Abastecimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLLabNumeroBomba: TRLLabel
        Left = 20
        Top = 48
        Width = 93
        Height = 16
        Align = faBottomOnly
        AutoSize = False
        Caption = 'N'#186' Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabNumeroTanque: TRLLabel
        Left = 119
        Top = 48
        Width = 93
        Height = 16
        Align = faBottomOnly
        AutoSize = False
        Caption = 'N'#186' Tanque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabDescrTipoCombustivel: TRLLabel
        Left = 218
        Top = 48
        Width = 200
        Height = 16
        Align = faBottomOnly
        AutoSize = False
        Caption = 'Combustivel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabValor: TRLLabel
        Left = 424
        Top = 48
        Width = 150
        Height = 16
        Align = faBottomOnly
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBandTotalGeral: TRLBand
      Left = 38
      Top = 217
      Width = 718
      Height = 33
      BandType = btSummary
      object RLLabTotalGeral: TRLLabel
        Left = 339
        Top = 15
        Width = 79
        Height = 16
        Caption = 'Total Geral:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBResultTotalGeral: TRLDBResult
        Left = 424
        Top = 15
        Width = 150
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'total_valor'
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLLabValor
        Info = riSum
        ParentFont = False
        Text = ''
      end
    end
  end
  object CDSAbastecimento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 312
    object CDSAbastecimentodata_abastecimento: TDateField
      FieldName = 'data_abastecimento'
    end
    object CDSAbastecimentototal_valor: TCurrencyField
      FieldName = 'total_valor'
      DisplayFormat = 'R$ ###,##0.00'
    end
    object CDSAbastecimentonumero_bomba: TSmallintField
      FieldName = 'numero_bomba'
    end
    object CDSAbastecimentonumero_tanque: TSmallintField
      FieldName = 'numero_tanque'
    end
    object CDSAbastecimentodescricao_tipo_combustivel: TWideStringField
      FieldName = 'descricao_tipo_combustivel'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = CDSAbastecimento
    Left = 160
    Top = 248
  end
end
