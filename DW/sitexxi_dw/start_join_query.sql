use sitexxi_dw;

select J.produtor, C.pais, D.mes, sum(TF.quantidade) as quantidade_total, sum(TF.preco_total) as preco_total
	from TF_Venda as TF
		inner join DIM_Data as D on TF.id_data = D.id_data
			inner join DIM_Cliente as C on TF.id_cliente = C.id_cliente
				inner join DIM_Jogo as J on TF.id_jogo = J.id_jogo
	where D.Ano between 2013 and 2016 and D.mes >= 1 and C.sexo = 'M'
	group by C.pais, J.produtor, D.mes
    order by preco_total desc;
