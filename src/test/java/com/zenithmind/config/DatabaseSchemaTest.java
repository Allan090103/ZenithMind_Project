package com.zenithmind.config;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
public class DatabaseSchemaTest {

    @Autowired
    private DataSource dataSource;

    @Test
    public void testSecurityTablesExist() {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        // Check users table
        List<Map<String, Object>> usersTable = jdbcTemplate.queryForList("SHOW TABLES LIKE 'users'");
        assertTrue(!usersTable.isEmpty(), "Table 'users' should exist");

        // Check authorities table
        List<Map<String, Object>> authoritiesTable = jdbcTemplate.queryForList("SHOW TABLES LIKE 'authorities'");
        assertTrue(!authoritiesTable.isEmpty(), "Table 'authorities' should exist");

        // Check columns in users table
        List<Map<String, Object>> usersColumns = jdbcTemplate.queryForList("DESCRIBE users");
        boolean hasUsername = usersColumns.stream().anyMatch(c -> c.get("Field").equals("username"));
        boolean hasPassword = usersColumns.stream().anyMatch(c -> c.get("Field").equals("password"));
        boolean hasEnabled = usersColumns.stream().anyMatch(c -> c.get("Field").equals("enabled"));

        assertTrue(hasUsername, "users table should have username column");
        assertTrue(hasPassword, "users table should have password column");
        assertTrue(hasEnabled, "users table should have enabled column");
    }
}
