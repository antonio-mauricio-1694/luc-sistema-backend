package br.com.lucsistema.contrller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.service.AcessoService;

@Controller
public class AcessoController {
	
	@Autowired
	private  AcessoService acessoService;
	
	public Acesso salvarAcesso(Acesso acesso) {
		
		return acessoService.save(acesso);
	}

}
