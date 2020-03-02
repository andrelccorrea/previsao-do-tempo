CLASS previsao_do_tempo

	EXPORTED:
		METHOD exibir_previsao_por_cidade( nome_da_cidade )	
	
	HIDDEN:
		METHOD obter_previsao_por_cidade( nome_da_cidade )
		METHOD obter_codigo_da_cidade( nome_da_cidade )
		METHOD converter_sigla_em_previsao()

ENDCLASS

METHOD obter_previsao_por_cidade( nome_da_cidade ) CLASS previsao_do_tempo

	LOCAL codigo_da_cidade
	LOCAL previsao_xml
	LOCAL http, xml, erro
	
	http := win_OleCreateObject( "MSXML2.ServerXMLHTTP.6.0" )
	xml := win_OleCreateObject( "MSXML2.DOMDocument.6.0" )
	
	codigo_da_cidade := ::obter_codigo_da_cidade( nome_da_cidade )
	
	IF !Empty( codigo_da_cidade )
		// TRY
			http:Open( "GET", "http://servicos.cptec.inpe.br/XML/cidade/7dias/" + codigo_da_cidade + "/previsao.xml", .F. )
		
			http:send()
			
			xml:loadXML( http:responseText )
		
			IF xml:parseError:errorCode != 0
				? "Erro ao ler o XML."
				? xml:parseError:reason
			ELSE
				previsao_xml := xml:xml
			ENDIF
		// CATCH erro
		// 	? "Erro ao consultar a previsão."
		// 	? erro:cDescription
		// END
	ENDIF

RETURN previsao_xml

METHOD exibir_previsao_por_cidade( nome_da_cidade ) CLASS previsao_do_tempo

	LOCAL previsao_xml := ::obter_previsao_por_cidade( nome_da_cidade )
	LOCAL xml := win_OleCreateObject( "MSXML2.DOMDocument.6.0" )
	LOCAL cidade, uf, atualizacao, previsoes, lista_de_elementos
	LOCAL elemento, elemento

	IF !Empty( previsao_xml )

		xml:loadXML( previsao_xml )
		cidade := xml:selectSingleNode("//nome"):text
		uf := xml:selectSingleNode("//uf"):text
		atualizacao := xml:selectSingleNode("//atualizacao"):text

		lista_de_elementos := xml:documentElement:childNodes;

		FOR EACH elemento IN lista_de_elementos
			IF elemento:hasChild
				
			ELSE
			
			ENDIF			
			? elemento:xml
		NEXT

	ENDIF

RETURN nil

METHOD obter_codigo_da_cidade( nome_da_cidade ) CLASS previsao_do_tempo
	
	LOCAL codigo_da_cidade
	LOCAL http, xml
	
	http := win_OleCreateObject( "MSXML2.ServerXMLHTTP.6.0" )
	xml := win_OleCreateObject( "MSXML2.DOMDocument.6.0" )

	http:Open( "GET", "http://servicos.cptec.inpe.br/XML/listaCidades?city=" + nome_da_cidade, .F. )
	
	http:send()
	
	xml:loadXML( http:responseText )

	IF xml:parseError:errorCode != 0
		? "Erro ao ler o XML"
		? xml:parseError:reason
	ELSE
		codigo_da_cidade := xml:selectSingleNode("//id"):text
	ENDIF	

RETURN codigo_da_cidade

METHOD converter_sigla_em_previsao( sigla ) CLASS previsao_do_tempo

	LOCAL previsao

	SWITCH sigla
		CASE "ec"
			previsao := "Encoberto com Chuvas Isoladas"
		CASE "ci"
			previsao := "Chuvas Isoladas"
		CASE "c"
			previsao := "Chuva"
		CASE "in"
			previsao := "Instável"
		CASE "pp"
			previsao := "Poss. de Pancadas de Chuva"
		CASE "cm"
			previsao := "Chuva pela Manhã"
		CASE "cn"
			previsao := "Chuva a Noite"
		CASE "pt"
			previsao := "Pancadas de Chuva a Tarde"
		CASE "pm"
			previsao := "Pancadas de Chuva pela Manhã"
		CASE "np"
			previsao := "Nublado e Pancadas de Chuva"
		CASE "pc"
			previsao := "Pancadas de Chuva"
		CASE "pn"
			previsao := "Parcialmente Nublado"
		CASE "cv"
			previsao := "Chuvisco"
		CASE "ch"
			previsao := "Chuvoso"
		CASE "t"
			previsao := "Tempestade"
		CASE "ps"
			previsao := "Predomínio de Sol"
		CASE "e"
			previsao := "Encoberto"
		CASE "n"
			previsao := "Nublado"
		CASE "cl"
			previsao := "Céu Claro"
		CASE "nv"
			previsao := "Nevoeiro"
		CASE "g"
			previsao := "Geada"
		CASE "ne"
			previsao := "Neve"
		CASE "nd"
			previsao := "Não Definido"
		CASE "pnt"
			previsao := "Pancadas de Chuva a Noite"
		CASE "psc"
			previsao := "Possibilidade de Chuva"
		CASE "pcm"
			previsao := "Possibilidade de Chuva pela Manhã"
		CASE "pct"
			previsao := "Possibilidade de Chuva a Tarde"
		CASE "pcn"
			previsao := "Possibilidade de Chuva a Noite"
		CASE "npt"
			previsao := "Nublado com Pancadas a Tarde"
		CASE "npn"
			previsao := "Nublado com Pancadas a Noite"
		CASE "ncn"
			previsao := "Nublado com Poss. de Chuva a Noite"
		CASE "nct"
			previsao := "Nublado com Poss. de Chuva a Tarde"
		CASE "ncm"
			previsao := "Nubl. c/ Poss. de Chuva pela Manhã"
		CASE "npm"
			previsao := "Nublado com Pancadas pela Manhã"
		CASE "npp"
			previsao := "Nublado com Possibilidade de Chuva"
		CASE "vn"
			previsao := "Variação de Nebulosidade"
		CASE "ct"
			previsao := "Chuva a Tarde"
		CASE "ppn"
			previsao := "Poss. de Panc. de Chuva a Noite"
		CASE "ppt"
			previsao := "Poss. de Panc. de Chuva a Tarde"
		CASE "ppm"
			previsao := "Poss. de Panc. de Chuva pela Manhã"
	ENDSWITCH

RETURN previsao