//package login.Repository;
//
////import login.Model.User; // Import your own User class
////import org.springframework.data.jpa.repository.JpaRepository;
////import org.springframework.data.jpa.repository.Query;
////import org.springframework.data.repository.query.Param;
////import org.springframework.stereotype.Repository;
//
//@Repository
//public interface UserRepository extends JpaRepository<User, Long> {
//
//    @Query("SELECT COUNT(u) > 0 FROM User u WHERE u.username = :username AND u.password = :password")
//    boolean isValidUser(@Param("username") String username, @Param("password") String password);
//}
