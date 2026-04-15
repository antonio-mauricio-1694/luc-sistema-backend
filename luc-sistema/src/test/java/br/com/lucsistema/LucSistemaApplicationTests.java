package br.com.lucsistema;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import br.com.lucsistema.contrller.AcessoController;
import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.repository.AcessoRepository;
import br.com.lucsistema.service.AcessoService;

@SpringBootTest(classes = LucSistemaApplication.class)
class LucSistemaApplicationTests {

	//@Autowired
	//private AcessoService acessoService;
	
	//@Autowired
	//private AcessoRepository acessoRepository;
	
	@Autowired
	private AcessoController acessoController;
	
	
	@Test
	 public void testeCadastraAcesso() {   
		
		Acesso acesso = new Acesso();
		
		acesso.setDescricao("ROLE_ADMIN");
		
		acessoController.salvarAcesso(acesso);
	}

}
