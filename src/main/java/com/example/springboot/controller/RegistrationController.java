package com.example.springboot.controller;

import com.example.springboot.domain.User;
import com.example.springboot.domain.dto.CaptchaResponseDto;
import com.example.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";
    @Autowired
    UserService userService;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String secret;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam("password2") String passwordConfirm,
                          @RequestParam("g-recaptcha-response") String captchaResponse,
                          @Valid User user,
                          BindingResult bindingResult,
                          Model model) {
        String url = String.format(CAPTCHA_URL, secret, captchaResponse);
        CaptchaResponseDto response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);

        if(!response.isSuccess()) {
            model.addAttribute("captchaError", "Неправильная капча");
            System.out.println(response.getErrorCodes());
        }

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);
        if (isConfirmEmpty) {
            model.addAttribute("password2Error", "Потдверждающий пароль не может быть пустым");
        }

        if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
            model.addAttribute("passwordError", "Пароли не совпадают");
        }

        if (isConfirmEmpty || bindingResult.hasErrors() || !response.isSuccess()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }
        if (!userService.addUser(user)) {
            String message = String.format(
                    "Пользователь с имененм %s уже существует",
                    user.getUsername()
            );
            model.addAttribute("usernameError", message);
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
        public String activate(Model model, @PathVariable String code) {
            boolean isActivate = userService.activateUser(code);

            if (isActivate) {
                model.addAttribute("message", "Аккаунт успешно активирован");
                model.addAttribute("messageType", "alert-success");
            } else {
                model.addAttribute("message", "Неправильный код активации");
                model.addAttribute("messageType", "alert-danger");
            }

            return "login";
        }
    }

