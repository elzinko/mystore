package fr.couderc.thomas.sarl.mystore.repository;

import fr.couderc.thomas.sarl.mystore.domain.Authority;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * Spring Data MongoDB repository for the Authority entity.
 */
public interface AuthorityRepository extends MongoRepository<Authority, String> {
}
