package com.svalero.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Appointment {
    private int id;
    private int property_id;
    private int customer_id;
    private int agent_id;
    private String name;
    private String last_name;
    private String email;
    private String phone;
    private String message;
    private Date appointment_datetime;
    private String status;
}
