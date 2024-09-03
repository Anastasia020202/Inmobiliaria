package com.svalero.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Customers {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
}
