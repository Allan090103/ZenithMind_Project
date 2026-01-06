package com.zenithmind.config;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;

@SpringBootTest
@AutoConfigureMockMvc
public class SecurityConfigTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void accessAdminPanelUnauthenticated_RedirectsToLogin() throws Exception {
        mockMvc.perform(get("/admin/panel"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @WithMockUser(username = "admin", roles = { "ADMIN" })
    public void accessAdminPanelAsAdmin_Succeeds() throws Exception {
        // Assuming admin/panel exists and returns 200. If it's a view, it might return
        // 200.
        // If the controller logic fails (e.g. missing other beans), it might return
        // 500, but auth should pass.
        // We mainly want to check that it's NOT 403 or 401.
        mockMvc.perform(get("/admin/panel"))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(username = "user", roles = { "USER" })
    public void accessAdminPanelAsUser_Forbidden() throws Exception {
        mockMvc.perform(get("/admin/panel"))
                .andExpect(status().isForbidden());
    }
}
