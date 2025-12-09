package br.com.lucsistema.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Objects;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "cupom_de_desconto")
@SequenceGenerator(name = "seq_cupom_de_desconto", sequenceName = "seq_cupom_de_desconto", allocationSize = 1, initialValue = 1)

public class CupomDesconto  implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cupom_de_desconto")
	private Long id;
	private String codigoDescricao;
	private BigDecimal valorRealDesconto;
	private BigDecimal valorPorcentDesconto;
	
	@Temporal(TemporalType.TIME)
	private Date dataVlidadeCupom;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCodigoDescricao() {
		return codigoDescricao;
	}

	public void setCodigoDescricao(String codigoDescricao) {
		this.codigoDescricao = codigoDescricao;
	}

	public BigDecimal getValorRealDesconto() {
		return valorRealDesconto;
	}

	public void setValorRealDesconto(BigDecimal valorRealDesconto) {
		this.valorRealDesconto = valorRealDesconto;
	}

	public BigDecimal getValorPorcentDesconto() {
		return valorPorcentDesconto;
	}

	public void setValorPorcentDesconto(BigDecimal valorPorcentDesconto) {
		this.valorPorcentDesconto = valorPorcentDesconto;
	}

	public Date getDataVlidadeCupom() {
		return dataVlidadeCupom;
	}

	public void setDataVlidadeCupom(Date dataVlidadeCupom) {
		this.dataVlidadeCupom = dataVlidadeCupom;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CupomDesconto other = (CupomDesconto) obj;
		return Objects.equals(id, other.id);
	}
	
	
	
	
	
	
	

}
