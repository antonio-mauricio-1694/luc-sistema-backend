package br.com.lucsistema.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.repository.AcessoRepository;

@Service
public class AcessoService {
	
	@Autowired
	private AcessoRepository acessoRepository;
		
	public Acesso save(Acesso acesso) {
		
		return acessoRepository.save(acesso);
	}
}
