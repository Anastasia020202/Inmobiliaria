package com.svalero.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Appointments {

    private int id;
    private int property_id;
    private int customer_id;
    private int agent_id;
    private Timestamp appointment_datetime;
    private String status;

}