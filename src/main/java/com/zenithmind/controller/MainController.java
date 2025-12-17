package com.zenithmind.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/profile-settings")
    public String profileSettings() {
        return "profile-settings";
    }
}
