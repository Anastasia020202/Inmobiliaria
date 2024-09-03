package com.svalero.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Property {

    private int id;
    private String address;
    private String type;
    private Double price;
    private int square_meters;
    private int rooms;
    private int bathrooms;
    private String description;
    private int agent_id;
    private byte[] image; // Cambia de String a byte[] para manejar la imagen
}
