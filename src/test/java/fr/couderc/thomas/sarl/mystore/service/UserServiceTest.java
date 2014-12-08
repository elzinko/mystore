package fr.couderc.thomas.sarl.mystore.service;

import fr.couderc.thomas.sarl.mystore.Application;
import fr.couderc.thomas.sarl.mystore.config.MongoConfiguration;
import fr.couderc.thomas.sarl.mystore.domain.User;
import fr.couderc.thomas.sarl.mystore.repository.UserRepository;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.inject.Inject;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

/**
 * Test class for the UserResource REST controller.
 *
 * @see UserService
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebAppConfiguration
@Import(MongoConfiguration.class)
public class UserServiceTest {

    @Inject
    private UserRepository userRepository;

    @Inject
    private UserService userService;

    @Test
    public void testFindNotActivatedUsersByCreationDateBefore() {
        userService.removeNotActivatedUsers();
        DateTime now = new DateTime();
        List<User> users = userRepository.findNotActivatedUsersByCreationDateBefore(now.minusDays(3));
        assertThat(users).isEmpty();
    }
}
