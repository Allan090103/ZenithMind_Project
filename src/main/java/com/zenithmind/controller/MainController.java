package com.zenithmind.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping("/")
    public String home() {
        return "login";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/modules")
    public String modules() {
        return "modules";
    }

    @GetMapping("/mood")
    public String mood() {
        return "mood";
    }

    @GetMapping("/support")
    public String support() {
        return "support";
    }
}


