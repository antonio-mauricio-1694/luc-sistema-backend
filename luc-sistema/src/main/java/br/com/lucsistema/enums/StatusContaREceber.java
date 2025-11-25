package br.com.lucsistema.enums;

public enum StatusContaREceber {
	
	
	COBRANCA("pagar"),
	VENCIDA("vencida"),
	ABERTA("aberta"),
	QUITADA("quitada");
	
	private String descricao;
	
	private StatusContaREceber( String descricao) {
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
