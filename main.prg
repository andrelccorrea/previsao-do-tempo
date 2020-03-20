FUNCTION main()

	LOCAL cidade := ""
	LOCAL previsao
	LOCAL sair := .F.
	
	SET DATE BRITISH
	SET DATE FORMAT "dd/mm/yyyy"
	
	DO WHILE .T.
		CLS
		
		? "Previsao do tempo - CPTEC/INPE"
		?
		ACCEPT "Digite o nome da cidade: " TO cidade

		CLS

		previsao := previsao_do_tempo():new():exibir_previsao_por_cidade( cidade )

		IF !Empty( previsao )
			? previsao
		ENDIF
		?
		?
		ACCEPT "Sair? S/N: " TO sair
		IF sair $ "Ss"
			CLS
			EXIT
		ENDIF
	ENDDO

RETURN nil