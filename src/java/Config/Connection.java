package Config;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

/**
 *
 * @author Samuel
 */
public class Connection {
    public DriverManagerDataSource Conectar() {
        DriverManagerDataSource datasource = new DriverManagerDataSource();
        datasource.setDriverClassName("org.mariadb.jdbc.Driver");
        datasource.setUrl("jdbc:mariadb://localhost:3306/inventory"); // Updated URL to use mariadb
        datasource.setUsername("root");
        datasource.setPassword("");
        return datasource;
    }
}
