package com.example.springboot.repos;

import com.example.springboot.domain.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface MessageRepo extends JpaRepository<Message, Long> {

    List<Message> findByTagLikeIgnoreCase(String tag);

}
