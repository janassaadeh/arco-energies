package com.senior.demo.Controllers;

import com.senior.demo.Responses.CompanyResponse;
import com.senior.demo.Responses.OperatorResponse;
import com.senior.demo.Service.CompanyService;
import com.senior.demo.Service.OperatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/operator")
public class OperatorController {
    @Autowired
    private  OperatorService operatorService;



    @GetMapping("/all")
    public ResponseEntity<List<OperatorResponse>> getAllOperators() {
        List<OperatorResponse> operators = operatorService.getAllOperators();
        return new ResponseEntity<>(operators, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OperatorResponse> getOperatorById(@PathVariable("id") String id) {
        OperatorResponse operator = operatorService.getOperatorById(id);
        if (operator != null) {
            return new ResponseEntity<>(operator, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }


    @PutMapping("/{id}")
    public ResponseEntity<OperatorResponse> updateOperator(@PathVariable("id") String id, @RequestBody OperatorResponse operator) {
        OperatorResponse updatedOperator = operatorService.updateOperator(id, operator);
        if (updatedOperator != null) {
            return new ResponseEntity<>(updatedOperator, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOperator(@PathVariable("id") String id) {
        operatorService.deleteOperator(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

}
