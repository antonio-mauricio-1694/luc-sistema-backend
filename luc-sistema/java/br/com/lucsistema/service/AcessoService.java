// src/main/java/br/com/lucsistema/service/AcessoService.java

package br.com.lucsistema.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.repository.AcessoRepository;

@Service
public class AcessoService {

    @Autowired
    private AcessoRepository acessoRepository;

    public Acesso save(Acesso acesso) { /*Salva ou atualiza o objeto no banco*/

        return acessoRepository.save(acesso);
    }

    public void deleteAcesso(Long id) { /*Deleta o registro pelo id*/

        acessoRepository.deleteById(id); /*Chama o delete nativo do JpaRepository*/
    }
}