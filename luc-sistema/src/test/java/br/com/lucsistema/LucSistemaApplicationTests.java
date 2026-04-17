package br.com.lucsistema;



import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.service.AcessoService;

@SpringBootTest
class LucSistemaApplicationTests {

 @Autowired
 private AcessoService acessoService;

 @Test
 void testeCadastraAcesso() {

     Acesso acesso = new Acesso();
     acesso.setDescricao("ROLE_ADMIN");

     Acesso salvo = acessoService.save(acesso);

     System.out.println("ID SALVO: " + salvo.getId());
 }
}