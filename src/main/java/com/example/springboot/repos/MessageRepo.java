package com.example.springboot.repos;

import com.example.springboot.domain.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


public interface MessageRepo extends CrudRepository<Message, Integer> {

    List<Message> findByTagLikeIgnoreCase(String tag);

    Message findById(Long id);
}
