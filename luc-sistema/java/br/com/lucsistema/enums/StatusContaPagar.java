package br.com.lucsistema.enums;

public enum StatusContaPagar {
	
	
	COBRANCA("pagar"),
	VENCIDA("vencida"),
	ABERTA("aberta"),
	QUITADA("quitada"),
	NEGOCIADA("renegociada");
	
	private String descricao;
	
	private StatusContaPagar( String descricao) {
		this.descricao = descricao;
		
	}
	
	public String getDescricao() {
		return descricao;
	}
	
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.descricao;
	}
	

}
