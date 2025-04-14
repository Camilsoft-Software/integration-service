package com.rjaguirrem.integration.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class IntegrationController {
  @GetMapping("/hola")
  public String holaMundo() {
    return "¡Hola, mundo!";
  }
}





