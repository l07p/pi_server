package com.example.todobackend;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Arrays;
import java.util.List;

@RestController
public class TodoController {

    @GetMapping("/todos")
    public List<String> getTodos() {
        return Arrays.asList("Learn Docker", "Develop Java App", "Use Angular");
    }
}
