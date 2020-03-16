FUNCTION main()

	LOCAL cidade := ""
	
	SET DATE BRITISH
	
	CLS
	
	? "Previsao do tempo - CPTEC/INPE"
	?
	ACCEPT "Digite o nome da cidade: " TO cidade
	?

	? previsao_do_tempo():new():exibir_previsao_por_cidade( cidade )

RETURN nil