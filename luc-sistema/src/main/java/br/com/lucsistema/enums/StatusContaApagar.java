package br.com.lucsistema.enums;

public enum StatusContaApagar {
	
	
	COBRANCA("pagar"),
	VENCIDA("vencida"),
	ABERTA("aberta"),
	QUITADA("quitada");
	
	private String descricao;
	
	private StatusContaApagar( String descricao) {
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
